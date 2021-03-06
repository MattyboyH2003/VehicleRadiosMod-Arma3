
if isServer then{
	if isDedicated then{
		diag_log "[VehicleRadios] Running PostInitClient.sqf (Dedicated Server)";
	}
	else{
		diag_log "[VehicleRadios] Running PostInitClient.sqf (Non-Dedicated Server)";
	};

}
else {
	diag_log "[VehicleRadios] Running PostInitClient.sqf (Client)";
};

diag_log "[VehicleRadios] Building Song Library";

_return = "getDirectoryFiles" callExtension ["Main", ["./Songs"]];

diag_log format ["[VehicleRadios] %1 (buildSongLibrary)", _return];


soundSourceList = [];

radioOnFunc = {
	params ["_target", "_player", "_params", "_songNum"];
	diag_log "[VehicleRadios] Playing Sound";

	_pos = _target getRelPos [0, 0];
	_obj = createSimpleObject ["a3\weapons_f\chemlight\chemlight_blue.p3d", _pos];
	hideObject _obj;

	_obj setVariable ["Owner", _target];

	soundSourceList pushBack _obj;

	_target setVariable ["radioOn", true];
	_obj say3D format ["song%1", _songNum];
};

_callRadioOnFunc = {
	params ["_target", "_player", "_params"];
	diag_log "[VehicleRadios] Calling Song Start";

	_songNum = [1,4] call BIS_fnc_randomInt;

	[_target, _player, _params, _songNum] remoteExec ["radioOnFunc", 0];
	diag_log "[VehicleRadios] Called Song Start"
};



radioOffFunc = {

	params ["_target", "_player", "_params"];
	diag_log "[VehicleRadios] Stopping Sound";

	{
		_owner = _x getVariable "Owner";
		if (_owner == _target) then {
			diag_log format ["[VehicleRadios] Sound source found in position %1", _forEachIndex];
			deleteVehicle _x;
			soundSourceList deleteAt _forEachIndex;
		};
	} forEach soundSourceList;

	_target setVariable ["radioOn", false];
};

_callRadioOffFunc = {
	params ["_target", "_player", "_params"];
	diag_log "[VehicleRadios] Calling Song End";

	[_target, _player, _params] remoteExec ["radioOffFunc", 0];
	diag_log "[VehicleRadios] Called Song End";
};



radioSkipFunc = {

	params ["_target", "_player", "_params", "_songNum"];
	diag_log "[VehicleRadios] Skipping Song";

	{
		_owner = _x getVariable "Owner";
		if (_owner == _target) then {
			diag_log format ["[VehicleRadios] Sound source found in position %1", _forEachIndex];
			deleteVehicle _x;
			soundSourceList deleteAt _forEachIndex;
		};
	} forEach soundSourceList;

	_pos = _target getRelPos [0, 0];
	_obj = createSimpleObject ["a3\weapons_f\chemlight\chemlight_blue.p3d", _pos];
	hideObject _obj;
	_obj setVariable ["Owner", _target];
	soundSourceList pushBack _obj;
	_obj say3D format ["song%1", _songNum];
};

_callRadioSkipFunc = {
	params ["_target", "_player", "_params"];
	diag_log "[VehicleRadios] Calling Song Skip";
	
	_songNum = [1,4] call BIS_fnc_randomInt;

	[_target, _player, _params, _songNum] remoteExec ["radioSkipFunc", 0];
	diag_log "[VehicleRadios] Called Song Skip"
};

_radioOn = ["radioOn", "Turn Radio On", "", _callRadioOnFunc, {!(_target getVariable ["radioOn", false])}] call ace_interact_menu_fnc_createAction; // Name, Display Name, Icon, Function, Condition
["LandVehicle", 1, ["ACE_SelfActions"], _radioOn, true] call ace_interact_menu_fnc_addActionToClass; // Class, Action Type, Menu to appear in, Action, Condition

_radioOff = ["radioOff", "Turn Radio Off", "", _callRadioOffFunc, {_target getVariable ["radioOn", false]}] call ace_interact_menu_fnc_createAction; // Name, Display Name, Icon, Function, Condition
["LandVehicle", 1, ["ACE_SelfActions"], _radioOff, true] call ace_interact_menu_fnc_addActionToClass; // Class, Action Type, Menu to appear in, Action, Condition

_radioSkip = ["radioSkip", "Skip Song", "", _callRadioSkipFunc, {(_target getVariable ["radioOn", false])}] call ace_interact_menu_fnc_createAction; // Name, Display Name, Icon, Function, Condition
["LandVehicle", 1, ["ACE_SelfActions"], _radioSkip, true] call ace_interact_menu_fnc_addActionToClass;

onEachFrame {
	{
		_owner = _x getVariable "Owner";
		if !(alive _owner) then {
			deleteVehicle _x;
			soundSourceList deleteAt _forEachIndex;
		}
		else{
			_newPos = _owner getRelPos [0, 0];
			_x setPos _newPos;
		};
	} forEach soundSourceList;
};

/*
params(array) remoteExec [functionName(string), targets(0 means all, -2 means all but server), run on jip? (boolean)]
*/

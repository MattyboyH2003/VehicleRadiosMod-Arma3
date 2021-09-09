
diag_log "[VehicleRadios] Running PostInitClient.sqf";

soundSourceList = [];

_radioOnFunc = {

	diag_log "[VehicleRadios] Playing Sound";

	_pos = _target getRelPos [0, 0];
	_obj = createSimpleObject ["a3\weapons_f\chemlight\chemlight_blue.p3d", _pos];
	hideObject _obj;

	_obj setVariable ["Owner", _target];

	soundSourceList pushBack _obj;

	_target setVariable ["radioOn", true];
	_obj say3D format ["song%1", [1,4] call BIS_fnc_randomInt];
};

_radioOffFunc = {

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

_radioSkipFunc = {
	diag_log "[VehicleRadio] Skipping Song";

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
	_obj say3D format ["song%1", [1,4] call BIS_fnc_randomInt];
};

_radioOn = ["radioOn", "Turn Radio On", "", _radioOnFunc, {!(_target getVariable ["radioOn", false])}] call ace_interact_menu_fnc_createAction; // Name, Display Name, Icon, Function, Condition
["LandVehicle", 1, ["ACE_SelfActions"], _radioOn, true] call ace_interact_menu_fnc_addActionToClass; // Class, Action Type, Menu to appear in, Action, Condition

_radioOff = ["radioOff", "Turn Radio Off", "", _radioOffFunc, {_target getVariable ["radioOn", false]}] call ace_interact_menu_fnc_createAction; // Name, Display Name, Icon, Function, Condition
["LandVehicle", 1, ["ACE_SelfActions"], _radioOff, true] call ace_interact_menu_fnc_addActionToClass; // Class, Action Type, Menu to appear in, Action, Condition

_radioSkip = ["radioSkip", "Skip Song", "", _radioSkipFunc, {(_target getVariable ["radioOn", false])}] call ace_interact_menu_fnc_createAction; // Name, Display Name, Icon, Function, Condition
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

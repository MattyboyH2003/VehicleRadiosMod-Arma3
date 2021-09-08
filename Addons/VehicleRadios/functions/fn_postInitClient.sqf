
diag_log "[VehicleRadios] Running PostInitClient.sqf";

/*

This works, if in doubt. Give up and use this

_radioOnFunc = {
	diag_log "[VehicleRadios] Playing Sound";
	_target say3D "song1";
};

_radioToggle = ["radioOn", "Turn Radio On", "", _radioOnFunc, {true}] call ace_interact_menu_fnc_createAction; // Name, Display Name, Icon, Function, Condition
["LandVehicle", 1, ["ACE_SelfActions"], _radioToggle, true] call ace_interact_menu_fnc_addActionToClass; // Class, Action Type, Menu to appear in, Action, Condition
*/

_radioOnFunc = {
	diag_log "[VehicleRadios] Playing Sound";
	_target setVariable ["radioOn", true];
	_target say3D "song1";
};

_radioOffFunc = {
	diag_log "[VehicleRadios] Stopping Sound";
	_target setVariable ["radioOn", false];
};

/*
_radioToggleModifierFunc = {
	params ["_target", "_player", "_params", "_actionData"];

    // Modify the action - index 1 is the display name, 2 is the icon...#

	_radioState = _target getVariable ["radioOn", "Unavailable"];

	if (_radioState isEqualTo "Unavailable") then {
		_target setVariable ["radioOn", false];
		_actionData set [1, "Turn Radio On"];
		_actionData set [3, _radioOnFunc];
	};
	if (_radioState isEqualTo true) then {
		_actionData set [1, "Turn Radio Off"];
		_actionData set [3, _radioOffFunc];
	};
	if (_radioState isEqualTo false) then {
		_actionData set [1, "Turn Radio On"];
		_actionData set [3, _radioOnFunc];
	};
};
*/

_fuckyWuckyFunc = {
	_radioState = _target getVariable ["radioOn", "Unavailable"];
	diag_log "[VehicleRadios] oopsie woopsie!! Uwu We make a fucky wucky!! A wittle fucko boingo! The code monkeys at our headquarters are working VEWY HAWD to fix this!";
	diag_log format ["[VehicleRadios] Radio State: %1", toString(_radioState)];
};


_radioOn = ["radioOn", "Turn Radio On", "", _radioOnFunc, {!(_target getVariable ["radioOn", false])}] call ace_interact_menu_fnc_createAction; // Name, Display Name, Icon, Function, Condition
["LandVehicle", 1, ["ACE_SelfActions"], _radioOn, true] call ace_interact_menu_fnc_addActionToClass; // Class, Action Type, Menu to appear in, Action, Condition

_radioOff = ["radioOff", "Turn Radio Off", "", _radioOffFunc, {_target getVariable ["radioOn", false]}] call ace_interact_menu_fnc_createAction; // Name, Display Name, Icon, Function, Condition
["LandVehicle", 1, ["ACE_SelfActions"], _radioOff, true] call ace_interact_menu_fnc_addActionToClass; // Class, Action Type, Menu to appear in, Action, Condition

/*
_enableRadioCondition = {
	(_target getVariable ["radioOn", nil]) == nil;
};

_enableRadio = ["enableRadio", "Enable Radio", "", _enableRadioFunc, _enableRadioCondition] call ace_interact_menu_fnc_createAction; // Name, Display Name, Icon, Function, Condition
["LandVehicle", 1, ["ACE_SelfActions"], _enableRadio, true] call ace_interact_menu_fnc_addActionToClass; // Class, Action Type, Menu to appear in, Action, Condition
*/
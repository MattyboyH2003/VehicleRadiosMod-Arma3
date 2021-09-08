
diag_log "[VehicleRadios] Running PostInitClient.sqf";

_radioOnFunc = {
	diag_log "[VehicleRadios] Playing Sound";
	_target setVariable ["radioOn", true];
	_target say3D format ["song%1", [1,4] call BIS_fnc_randomInt];
};

_radioOffFunc = {
	diag_log "[VehicleRadios] Stopping Sound";
	_target setVariable ["radioOn", false];
};

_radioOn = ["radioOn", "Turn Radio On", "", _radioOnFunc, {!(_target getVariable ["radioOn", false])}] call ace_interact_menu_fnc_createAction; // Name, Display Name, Icon, Function, Condition
["LandVehicle", 1, ["ACE_SelfActions"], _radioOn, true] call ace_interact_menu_fnc_addActionToClass; // Class, Action Type, Menu to appear in, Action, Condition

_radioOff = ["radioOff", "Turn Radio Off", "", _radioOffFunc, {_target getVariable ["radioOn", false]}] call ace_interact_menu_fnc_createAction; // Name, Display Name, Icon, Function, Condition
["LandVehicle", 1, ["ACE_SelfActions"], _radioOff, true] call ace_interact_menu_fnc_addActionToClass; // Class, Action Type, Menu to appear in, Action, Condition



/*
This works, if in doubt. Give up and use this

_radioOnFunc = {
	diag_log "[VehicleRadios] Playing Sound";
	_target say3D "song1";
};

_radioToggle = ["radioOn", "Turn Radio On", "", _radioOnFunc, {true}] call ace_interact_menu_fnc_createAction; // Name, Display Name, Icon, Function, Condition
["LandVehicle", 1, ["ACE_SelfActions"], _radioToggle, true] call ace_interact_menu_fnc_addActionToClass; // Class, Action Type, Menu to appear in, Action, Condition

_fuckyWuckyFunc = {
	_radioState = _target getVariable ["radioOn", "Unavailable"];
	diag_log "[VehicleRadios] oopsie woopsie!! Uwu We make a fucky wucky!! A wittle fucko boingo! The code monkeys at our headquarters are working VEWY HAWD to fix this!";
	diag_log format ["[VehicleRadios] Radio State: %1", toString(_radioState)];
};
*/
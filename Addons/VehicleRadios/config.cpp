
/*
CfgPatches
*/

class CfgPatches
{
	class VehicleRadios
	{
		name = "VehicleRadios";
		author[] = {"Mattyboy"};
		url = "https://github.com/MattyboyH2003";
		requiredVersion = 1;
		requiredAddons[] = {"cba_main"};
		units[] = {};
		weapons[] = {};
	};
};


/*
CfgFunctions
*/

class CfgFunctions
{
	class VehicleRadios
	{
		class functions
		{
			file = "VehicleRadios\functions";
			class postInitClient
			{
				postInit = 1;
			};
		};
	};
};


/*
CfgSettings
*/

class CfgSettings {
    class CBA {
        class Versioning {
            class VehicleRadio {
                class dependencies {
                    CBA[] = {"cba_main", {3,12,0}, "(true)"};
                };
            };
        };
    };
};

class CfgSounds{
	class Song1 
		{
			name = "Taylor Swift - I Knew You Were Trouble";	
			sound[] = {"VehicleRadios\songs\Taylor Swift - I Knew You Were Trouble.wav",1,1,4,1,1,1,0};	//The 4 indicates the distance at which the sound will be heard;
		};
	class Song2
		{
			name = "Michael Jackson - Smooth Criminal";	
			sound[] = {"VehicleRadios\songs\Michael Jackson - Smooth Criminal.wav",1,1,4,1,1,1,0};	
		};
	class Song3
		{
			name = "Fountains of Wayne - Stacy's Mom";	
			sound[] = {"VehicleRadios\songs\Fountains of Wayne - Stacy's Mom.wav",1,1,4,1,1,1,0};	
		};
	class Song4
		{
			name = "Payday 2 Official Soundtrack - I Will Give You My All";	
			sound[] = {"VehicleRadios\songs\Payday 2 Official Soundtrack - I Will Give You My All.wav",1,1,4,1,1,1,0};	
		};
	};
};
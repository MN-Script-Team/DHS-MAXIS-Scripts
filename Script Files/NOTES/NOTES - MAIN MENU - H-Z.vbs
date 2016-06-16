'STATS GATHERING----------------------------------------------------------------------------------------------------
name_of_script = "NOTES - MAIN MENU (H-Z).vbs"
start_time = timer

'Message alerting the worker that the Power Pad is updated. This script is due for deletion in the June 2016 release
veronica_message = MsgBox("You appear to be using an old Power Pad! A new version was released earlier this year. It looks like you need to update! The separate NOTES buttons are now combined. Contact a scripts administrator and ask them to update your scripts by running the scripts installer again!" & vbNewLine & vbNewLine & "The separate NOTES main menus will become disconnected on or before June 27, 2016. Access to these scripts will be lost unless your Power Pad is updated!" & vbNewLine & vbNewLine & "The script will now continue.", vbExclamation)

'LOADING FUNCTIONS LIBRARY FROM GITHUB REPOSITORY===========================================================================
IF IsEmpty(FuncLib_URL) = TRUE THEN	'Shouldn't load FuncLib if it already loaded once
	IF run_locally = FALSE or run_locally = "" THEN		'If the scripts are set to run locally, it skips this and uses an FSO below.
		IF use_master_branch = TRUE THEN			'If the default_directory is C:\DHS-MAXIS-Scripts\Script Files, you're probably a scriptwriter and should use the master branch.
			FuncLib_URL = "https://raw.githubusercontent.com/MN-Script-Team/BZS-FuncLib/master/MASTER%20FUNCTIONS%20LIBRARY.vbs"
		Else																		'Everyone else should use the release branch.
			FuncLib_URL = "https://raw.githubusercontent.com/MN-Script-Team/BZS-FuncLib/RELEASE/MASTER%20FUNCTIONS%20LIBRARY.vbs"
		End if
		SET req = CreateObject("Msxml2.XMLHttp.6.0")				'Creates an object to get a FuncLib_URL
		req.open "GET", FuncLib_URL, FALSE							'Attempts to open the FuncLib_URL
		req.send													'Sends request
		IF req.Status = 200 THEN									'200 means great success
			Set fso = CreateObject("Scripting.FileSystemObject")	'Creates an FSO
			Execute req.responseText								'Executes the script code
		ELSE														'Error message, tells user to try to reach github.com, otherwise instructs to contact Veronica with details (and stops script).
			MsgBox 	"Something has gone wrong. The code stored on GitHub was not able to be reached." & vbCr &_
					vbCr & _
					"Before contacting Veronica Cary, please check to make sure you can load the main page at www.GitHub.com." & vbCr &_
					vbCr & _
					"If you can reach GitHub.com, but this script still does not work, ask an alpha user to contact Veronica Cary and provide the following information:" & vbCr &_
					vbTab & "- The name of the script you are running." & vbCr &_
					vbTab & "- Whether or not the script is ""erroring out"" for any other users." & vbCr &_
					vbTab & "- The name and email for an employee from your IT department," & vbCr & _
					vbTab & vbTab & "responsible for network issues." & vbCr &_
					vbTab & "- The URL indicated below (a screenshot should suffice)." & vbCr &_
					vbCr & _
					"Veronica will work with your IT department to try and solve this issue, if needed." & vbCr &_
					vbCr &_
					"URL: " & FuncLib_URL
					script_end_procedure("Script ended due to error connecting to GitHub.")
		END IF
	ELSE
		FuncLib_URL = "C:\BZS-FuncLib\MASTER FUNCTIONS LIBRARY.vbs"
		Set run_another_script_fso = CreateObject("Scripting.FileSystemObject")
		Set fso_command = run_another_script_fso.OpenTextFile(FuncLib_URL)
		text_from_the_other_script = fso_command.ReadAll
		fso_command.Close
		Execute text_from_the_other_script
	END IF
END IF
'END FUNCTIONS LIBRARY BLOCK================================================================================================

'If a script_repository is not declared then set it to be master, because the user is likely a scriptwriter.
IF script_repository = "" THEN script_repository = "https://raw.githubusercontent.com/MN-Script-Team/DHS-MAXIS-Scripts/master/Script Files/"

'This runs the new MAIN MENU script. This entire file will be removed once all agencies update their Power Pads.
script_URL = script_repository & "/NOTES/NOTES - MAIN MENU.vbs"
IF run_locally = False THEN
	SET req = CreateObject("Msxml2.XMLHttp.6.0")				'Creates an object to get a script_URL
	req.open "GET", script_URL, FALSE									'Attempts to open the script_URL
	req.send													'Sends request
	IF req.Status = 200 THEN									'200 means great success
		Set fso = CreateObject("Scripting.FileSystemObject")	'Creates an FSO
		Execute req.responseText								'Executes the script code
	ELSE														'Error message, tells user to try to reach github.com, otherwise instructs to contact Veronica with details (and stops script).
		MsgBox 	"Something has gone wrong. The code stored on GitHub was not able to be reached." & vbCr &_ 
				vbCr & _
				"Before contacting Veronica Cary, please check to make sure you can load the main page at www.GitHub.com." & vbCr &_
				vbCr & _
				"If you can reach GitHub.com, but this script still does not work, ask an alpha user to contact Veronica Cary and provide the following information:" & vbCr &_
				vbTab & "- The name of the script you are running." & vbCr &_
				vbTab & "- Whether or not the script is ""erroring out"" for any other users." & vbCr &_
				vbTab & "- The name and email for an employee from your IT department," & vbCr & _
				vbTab & vbTab & "responsible for network issues." & vbCr &_
				vbTab & "- The script URL indicated below (a screenshot should suffice)." & vbCr &_
				vbCr & _
				"Veronica will work with your IT department to try and solve this issue, if needed." & vbCr &_ 
				vbCr &_
				"URL: " & script_URL
				script_end_procedure("Script ended due to error connecting to GitHub.")
	END IF
ELSE
	Set run_another_script_fso = CreateObject("Scripting.FileSystemObject")
	Set fso_command = run_another_script_fso.OpenTextFile(script_URL)
	text_from_the_other_script = fso_command.ReadAll
	fso_command.Close
	Execute text_from_the_other_script
END IF
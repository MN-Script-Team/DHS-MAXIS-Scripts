'GATHERING STATS----------------------------------------------------------------------------------------------------
name_of_script = "DAIL - STUDENT INCOME.vbs"
start_time = timer

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

'<<DELETE REDUNDANCIES!

EMConnect ""

'------------------THIS SCRIPT IS DESIGNED TO BE RUN FROM THE DAIL SCRUBBER.
'------------------As such, it does NOT include protections to be ran independently.

EMSendKey "n" + "<enter>"
EMWaitReady 1, 0
EMSendKey "<PF9>"
EMWaitReady 1, 0

EMSendKey "STUDENT INCOME HAS ENDED - REVIEW FS AND/OR HC RESULTS/APP" + "<newline>"
EMSendKey "* Sending financial aid form. TIKLed for 10-day return." + "<newline>"
EMSendKey "---" + "<newline>"

BeginDialog worker_sig_dialog, 0, 0, 191, 57, "Worker signature"
  EditBox 35, 25, 50, 15, worker_sig
  ButtonGroup ButtonPressed_worker_sig_dialog
    OkButton 135, 10, 50, 15
    CancelButton 135, 30, 50, 15
  Text 25, 10, 75, 10, "Sign your case note."
EndDialog

Dialog worker_sig_dialog
If ButtonPressed_worker_sig_dialog = 0 then stopscript

EMSendKey worker_sig + "<PF3>"
EMWaitReady 1, 0
EMSendKey "<PF3>"
EMWaitReady 1, 0

'Now it will TIKL out for this case.

EMSendKey "w" + "<enter>"
EMWaitReady 1, 0

'The following will generate a TIKL formatted date for 10 days from now.

If DatePart("d", Now + 10) = 1 then TIKL_day = "01"
If DatePart("d", Now + 10) = 2 then TIKL_day = "02"
If DatePart("d", Now + 10) = 3 then TIKL_day = "03"
If DatePart("d", Now + 10) = 4 then TIKL_day = "04"
If DatePart("d", Now + 10) = 5 then TIKL_day = "05"
If DatePart("d", Now + 10) = 6 then TIKL_day = "06"
If DatePart("d", Now + 10) = 7 then TIKL_day = "07"
If DatePart("d", Now + 10) = 8 then TIKL_day = "08"
If DatePart("d", Now + 10) = 9 then TIKL_day = "09"
If DatePart("d", Now + 10) > 9 then TIKL_day = DatePart("d", Now + 10)

If DatePart("m", Now + 10) = 1 then TIKL_month = "01"
If DatePart("m", Now + 10) = 2 then TIKL_month = "02"
If DatePart("m", Now + 10) = 3 then TIKL_month = "03"
If DatePart("m", Now + 10) = 4 then TIKL_month = "04"
If DatePart("m", Now + 10) = 5 then TIKL_month = "05"
If DatePart("m", Now + 10) = 6 then TIKL_month = "06"
If DatePart("m", Now + 10) = 7 then TIKL_month = "07"
If DatePart("m", Now + 10) = 8 then TIKL_month = "08"
If DatePart("m", Now + 10) = 9 then TIKL_month = "09"
If DatePart("m", Now + 10) > 9 then TIKL_month = DatePart("m", Now + 10)

TIKL_year = DatePart("yyyy", Now + 10)

EMSetCursor 5, 18
EMSendKey TIKL_month & TIKL_day & TIKL_year - 2000
EMSetCursor 9, 3
EMSendKey "Financial aid form should have returned by now. If not received and processed, take appropriate action. (TIKL auto-generated from script)." + "<enter>"
EMWaitReady 1, 0
EMSendKey "<PF3>"
MsgBox "MAXIS updated for student income status. A case note has been made, and a TIKL has been sent for 10 days from now. A financial aid form should be sent to the client."

script_end_procedure("")

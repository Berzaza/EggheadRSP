#Requires AutoHotkey v2.0.0
MyGui := Gui("+AlwaysOnTop  +Owner -Caption")
; Create a list view with red background
MyGui.BackColor := "Black"
MyGui.SetFont("underline cWhite s12","Constantia")
CoordMode "Mouse", "Window"
OnMessage 0x0201, WM_LBUTTONDOWN
free :=true
mining := false
K::ExitApp
WM_LBUTTONDOWN(wParam, lParam, msg, hwnd) {

    DllCall("PostMessage", "uint", MyGui.Hwnd, "uint", 0x00A1, "uint", 2, "uint", 0)
}

SaveFile := A_ScriptDir "\SaveFile.ini"
if FileExist(A_ScriptDir "\SaveFile.ini"){


} else {
  FileAppend(
    "[General]`n"



    ,SaveFile,"UTF-16-RAW")

    ; leave on death saving
    IniWrite("0",SaveFile, "General", "leave_on_death")
    IniWrite("0",SaveFile, "General", "shutdown_on_death")
    IniWrite("0",SaveFile, "General", "leave_on_item")
    IniWrite("0",SaveFile, "General", "shutdown_on_item")
    ;auto eat saving
    ;webhook saving
    IniWrite("0",SaveFile, "General", "discord_webhook")
    ;use webhook
    IniWrite("0",SaveFile, "General", "use_webhook")
}



LV := MyGui.Add("Tab2", "BackgroundBlack", ["Main","Extra","Help/Info","Credits"])

LV.Move(10, 20, 400, 570)
LV.UseTab(4)
MyGui.Add("Text",,"Developer: Egghead" . "`n" . "Logo-maker: Knox" . "`n" . "Idea Suggester: Kumori")
MyGui.Add("Picture", "x200 y150 w200 h200 BackgroundTrans ", A_ScriptDir "/imgs/egghead.png")
LV.UseTab(1)

MyGui.Add("Button", "vSaveData", "Press to save current settings.").OnEvent("Click",save_Button_Click)
MyGui.Add("Text",,"Item: (Not required)")
PreferredItem := MyGui.AddDropDownList("vChosenStarterCard", ["Ruby","Gold Ore"])
MyGui.Add("Text",,"Farms:")
MyGui.Add("Button", "vStartFarm", "Start-Farm").OnEvent("Click",startfarm_Button_Click)

MyGui.Add("Text",,"Choose one: (Not required) ")

LeaveOnDeath := MyGui.Add("CheckBox", "vLeaveOnDeath", "Leave on death.")
ShutdownOnDeath := MyGui.Add("CheckBox", "vShutdownOnDeath", "Shutdown PC on death.")
MyGui.Add("Text",,"Choose one: (Not required) ")
LeaveOnItem := MyGui.Add("CheckBox", "vLeaveOnItem", "Leave on item.")
ShutdownOnItem := MyGui.Add("CheckBox", "vShutdownOnItem", "Shutdown PC on item.")
MyGui.Add("Picture", "x200 y350 w200 h200 BackgroundTrans ", A_ScriptDir "/imgs/egghead.png")
MyGui.Show("w420 h600")

LV.UseTab(2)
MyGui.Add("Text",,"Discord webhook: ")
MyGui.SetFont("underline cBlack s12","Constantia")
DiscordWebhook := MyGui.Add("Edit","r1 vMyEdit w230", "")
MyGui.SetFont("underline cWhite s12","Constantia")
UseWebhook := MyGui.Add("CheckBox", "vUseWebhook", "Use Webhook")
MyGui.Add("Picture", "x200 y150 w200 h200 BackgroundTrans ", A_ScriptDir "/imgs/egghead.png")
LV.UseTab(3)
MyGui.Add("Text",,"If you experience a bug make a ticket," . "`n" . " explain the bug" . "`n" . " send a picture/video if you can " . "`n" . " and I'll help you best I can.")
MyGui.Add("Picture", "x200 y150 w200 h200 BackgroundTrans ", A_ScriptDir "/imgs/egghead.png")
LV.UseTab(5)


MyGui.Add("Picture", "x300 y150 w100 h100 BackgroundTrans ", A_ScriptDir "/imgs/egghead.png")
WinSetTransparent 220, "RuneSlayerMacro.ahk"


if IniRead(SaveFile,"General","leave_on_death") == 0 or  IniRead(SaveFile,"General","leave_on_death") == 1
{
    LeaveOnDeath.Value := IniRead(SaveFile, "General", "leave_on_death")
    ShutdownOnDeath.Value := IniRead(SaveFile, "General", "shutdown_on_death")
    LeaveOnItem.Value := IniRead(SaveFile, "General", "leave_on_item")
    ShutdownOnItem.Value := IniRead(SaveFile, "General", "shutdown_on_item")
    UseWebhook.Value := IniRead(SaveFile, "General", "use_webhook")
    DiscordWebhook.Value :=  IniRead(SaveFile, "General", "discord_webhook")

}
;Save button logic
save_Button_Click(btn,info)
{
    ; leave on death saving
    IniWrite(ControlGetChecked(LeaveOnDeath),SaveFile, "General", "leave_on_death")
    IniWrite(ControlGetChecked(ShutdownOnDeath),SaveFile, "General", "shutdown_on_death")
    IniWrite(ControlGetChecked(LeaveOnItem),SaveFile, "General", "leave_on_item")
    IniWrite(ControlGetChecked(ShutdownOnItem),SaveFile, "General", "shutdown_on_item")

    ;auto eat saving
    ;webhook saving
    IniWrite(ControlGetText(DiscordWebhook),SaveFile, "General", "discord_webhook")
    ;use webhook
    IniWrite(ControlGetChecked(UseWebhook),SaveFile, "General", "use_webhook")

  ;  MsgBox(IniRead(SaveFile,"General","Leave_on_death"))
 ;  FileAppend("Leave_on_death = " ControlGetChecked(LeaveOnDeath) . "`n" . "Auto_eat = " ControlGetChecked(AutoEat) . "`n" . "Discord_webhook = " . ControlGetText(DiscordWebhook) , SaveFile)
}
CheckInv(Item) {
  global free
  global mining
    If Item == "Platinum"{

       Send "{TAB down}{TAB up}"
    Sleep(600)
    Click(206,178)
    Sleep(200)
    Click(183,178)
    Sleep(200)
    Send("platinum ore")
    Sleep(200)
      ; Interprets the coordinates below as relative to the screen rather than the active window's client area.
    if ImageSearch( &FoundX, &FoundY, 0, 0, 800, 630, "*10 " A_ScriptDir "/imgs/Platinum.bmp"){
        MouseMove(FoundX+10,FoundY+40,2)
        MouseMove(FoundX+10,FoundY+35,2)
        MouseMove(FoundX+10,FoundY+50,2)
        Sleep(500)
        Click
         Sleep(500)
        Send "{BackSpace}"
        Sleep(300)
        if ImageSearch( &FX, &FY, 0, 0, 800, 630, "*100 " A_ScriptDir "/imgs/DelConfirm.bmp"){


        Sleep(200)
        MouseMove(410,375,2)
        Click(411,376)
        MouseMove(411,376,2)
        Click
        Sleep(400)
        Send("99999")
        Sleep(500)
        MouseMove(FX+11,FY+42,2)
        Click(FX+12,FY+43)
        Click(FX+12,FY+43)
        Sleep(100)
        Send "{TAB down}{TAB up}"

        Sleep(500)
        ServerHop()
        }else{
        Sleep(200)
        MouseMove(368,382)
        Click(368,382)
        MouseMove(368,382)
        Click
        Sleep(400)
        Send("99999")
        Sleep(500)
        MouseMove(363,417,40)
        Click(361,416)
        MouseMove(363,417,40)
        Click(361,416)
        Sleep(100)
        Send "{TAB down}{TAB up}"

        Sleep(500)
        ServerHop()

        }


    }
    else
      Send "{TAB down}{TAB up}"
      ServerHop()


    }
}



Mine(bool){
  global mining
  mining := false
  if bool == true{
    Send "{e down}{e up}"
    CheckingForDone := true
    last := A_TickCount
    while CheckingForDone == true{
      Send "{e down}{e up}"

     if ImageSearch( &FoundX, &FoundY, 0, 0, 800, 630, "*10 " A_ScriptDir "/imgs/HarvestingDone.bmp"){
      Sleep(500)
      last := A_TickCount
      Send "{e down}{e up}"

      }
      if ImageSearch( &FoundX, &FoundY, 0, 0, 800, 630, "*50 " A_ScriptDir "/imgs/Progress.bmp"){
      mining := true
        last := A_TickCount

      }
      if (A_TickCount - last >  2000){
        if mining == true{
          CheckInv("Platinum")
          mining := false
          CheckingForDone := false
        }else{
          ServerHop()
          mining := false
          CheckingForDone := false
          }



      }


     }
      last := A_TickCount
  }
}
DetectSpawn(){
  found := false
  while found == false{
    if ImageSearch( &FoundX, &FoundY, 45, 114, 233, 141, "*20 " A_ScriptDir "/imgs/ManaBar.bmp"){
      Mine(true)
      found:= true
      return true
    }
  }

}
DetectTitleScreen(){
  found := false

  while found == false{
    if ImageSearch( &FoundX, &FoundY, 0, 0, 800, 630, "*60 " A_ScriptDir "/imgs/TitleScreen.bmp"){
      found:= true
    }
  }

  if ImageSearch( &FoundX, &FoundY, 0, 0, 800, 630, "*60 " A_ScriptDir "/imgs/TitleScreen.bmp") and found == true{
    Sleep(200)
    Click(400,400)
    Click(400,400)
    Sleep(700)

    MouseMove(405,446,12) ; click continue
    Click(405,446) ; click
    Click(405,446) ; click
    Sleep(100) ; wait
    MouseMove(407,445,12) ; move slightly
    Click(405,445) ; click
    Click(405,445) ; click
    Sleep(100) ; wait
    MouseMove(404,445,12) ; move slightly
    Click(404,445) ; click
    Click(404,445) ; click
    Sleep(400)


    MouseMove(388,204,10)
    Sleep(400)
    Click(388,202)
    Click(388,202)
    Sleep(2000)
    Scrolling := true
    last := A_TickCount
    While Scrolling == true{
    Send "{WheelDown}"
    if (A_TickCount - last >  2000){
    Scrolling := false

    }
    }

   MouseMove(350,352,10)
    Sleep(200)
   MouseMove(386,352,10)
   Click(386,352)
   Sleep(700)
   MouseMove(409,415,10)
   Click(409,415)
   Sleep(100)
   Click(409,415)
   Sleep(1000)
   Click(406,114)
   MouseMove(406,114,10)
   Sleep(100)
   Click(406,114)
   MouseMove(407,116,10)
   Sleep(100)
   Click(406,114)
   DetectSpawn()
  }else{

  }

DetectSpawn()
}
ServerHop(){
  Send "{m down}{m up}"
   Sleep(200)
  Click(461,201)
  Sleep(100)
  Click(458,201)
  Sleep(100)
  Click(458,201)
  Sleep(400)
  MouseMove(361,385,5)
  Click(363,387)
  Sleep(100)
  Click(363,387)
  MouseMove(361,385,5)
  Click(363,387)
  DetectTitleScreen()
}

startfarm_Button_Click(btn, info)
{
  global checking
    if WinExist("Roblox")
    {
    WinActivate("Roblox")

    WinGetPos ,, &Width, &Height, "Roblox"
    WinMove  0,0 ,0,0, "Roblox"


    }

    ServerHop()








}

FileDelete(A_ScriptName)




#Requires AutoHotkey v2.0.0
#Include  %A_ScriptDir%\FindText.ahk
#Include  %A_ScriptDir%\DiscordBuilder.ahk
MyGui := Gui("+AlwaysOnTop  +Owner -Caption")
OptionsGui := Gui("+AlwaysOnTop  +Owner")
; Create a list view with red background
MyGui.BackColor := "Black"
MyGui.SetFont("underline cWhite s12","Constantia")
OptionsGui.BackColor := "Black"
OptionsGui.SetFont("underline cWhite s12","Constantia")
SendMode "Input"
CoordMode "Mouse", "Window"
CoordMode "Pixel", "Window"
OnMessage 0x0201, WM_LBUTTONDOWN

free :=true
mining := false
dothing := true
F7::ExitApp


WM_LBUTTONDOWN(wParam, lParam, msg, hwnd) {
    if dothing == true {
    DllCall("PostMessage", "uint", MyGui.Hwnd, "uint", 0x00A1, "uint", 2, "uint", 0)
    }

}



SaveFile := A_ScriptDir "\SaveFile.ini"



LV := MyGui.Add("Tab2", "BackgroundBlack", ["Main","Webhook","Help/Info","Credits"])

LV.Move(10, 20, 400, 570)

LV2 := OptionsGui.Add("Tab2", "BackgroundBlack", ["Main"])
LV2.Move(10, 20, 280, 370)
LV.UseTab(4)
MyGui.Add("Text",,"Developer: Egghead" . "`n" . "Logo-maker: Knox" . "`n" . "Idea Suggester: Knox")
MyGui.Add("Picture", "x200 y150 w200 h200 BackgroundTrans ", A_ScriptDir "/imgs/egghead.png")
LV.UseTab(1)

MyGui.Add("Button", "vSaveData", "Press to save current settings.").OnEvent("Click",save_Button_Click)
MyGui.Add("Text",,"Training:")
PreferredItem := MyGui.AddDropDownList("vChosenStarterCard", ["Treadmill","Pull-up","Tool","Technique"])

MyGui.Add("Text",,"Farms:")
MyGui.Add("Button", "vStartFarm", "Start-Farm").OnEvent("Click",startfarm_Button_Click)

MyGui.Add("Text",,"Options:")
LeaveOnDeath := MyGui.Add("CheckBox", "vLeaveOnDeath", "Leave on death.")
ShutdownOnDeath := MyGui.Add("CheckBox", "vShutdownOnDeath", "Shutdown PC on death.")
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
OptionsGui.Add("Text",,"Training type:")
MachineSide := OptionsGui.AddDropDownList("vMachine_Side", ["Agility","Stamina"])
MachineSide2 := OptionsGui.AddDropDownList("vMachine_Side2", ["Fast","Slow"])
OptionsGui.Add("Text",,"Machine Level / Tool type:")
ChosenSlot := OptionsGui.AddDropDownList("vChosenSlot", ["1","2","3","4","5"])
ChosenSlot.Value := 1
ChosenSlot2 := OptionsGui.AddDropDownList("vChosenSlot2", ["Squats","Pushups","Situps"])
OptionsGui.Add("Text",,"Stamina to regen to (Estimate):")
ChosenStam := OptionsGui.AddDropDownList("vChosenStam", ["25%","50%","100%"])
ChosenStam.Value := 3
OptionsGui.Add("Button", "vStartReady", "Start-Farm").OnEvent("Click",startready_Button_Click)

MyGui.Add("Picture", "x300 y150 w100 h100 BackgroundTrans ", A_ScriptDir "/imgs/egghead.png")
WinSetTransparent 220, "EggheadsMacro.ahk" ; change this for testing


loopcount := 0


MaxFatigueAlert(){
    if UseWebhook.Value == 1 {
        embed := EmbedBuilder()
        webhook := Discord.Webhook(DiscordWebhook.Value)
        embed.setTitle("Alert!")
        embed.setDescription("Max Fatigue!")
        embed.setAuthor({name:"Egghead's Macro",icon_url:thumbnail.attachmentName})
        embed.setColor(0xFFFFFF)
        embed.addFields([
        {
        name:"You have reached max fatigue.",
        value: "@everyone"
        },

        ])
            webhook.send({
            embeds: [embed],
            files: [thumbnail]
        })

    }

}

LoopCountAlert(){
    if UseWebhook.Value == 1 {
        embed := EmbedBuilder()
        webhook := Discord.Webhook(DiscordWebhook.Value)
        embed.setTitle("Treadmills")
        embed.setDescription("Starting Treadmill Round: " . loopcount)
        embed.setAuthor({name:"Egghead's Macro",icon_url:thumbnail.attachmentName})
        embed.setColor(0xFFFFFF)

        embed.addFields([
        {
        name:"Current Treadmill Round: " . loopcount,
        value: "nil"
        },

        ])
            webhook.send({
            embeds: [embed],
            files: [thumbnail]
        })
    }

}

CheckIfMaxStamina(){
 if PixelSearch( &FoundX, &FoundY, 118, 159, 121, 146, 0x4E9BE9,5){
    return true
    }
  else
    return false
}

CheckIf50Stamina(){
 if PixelSearch( &FoundX, &FoundY, 73, 159, 65, 146, 0x4E9BE9,5){
    return true
    }
  else
    return false
}
CheckIf25Stamina(){
 if PixelSearch( &FoundX, &FoundY, 45, 159, 42, 146, 0x4E9BE9,5){
    return true
    }
  else
    return false
}
CheckIfMinStamina(){
 if PixelSearch( &FoundX, &FoundY, 30, 159, 35, 146, 0x4E9BE9,5){
    return false

    }
  else
    return true
}

CheckIfMinFatigue(){
 if PixelSearch( &FoundX, &FoundY, 212, 160, 233, 130,  0xB48C0C,5){
    return false

    }
  else
    return true
}

CheckIfToolFatigue(){
 if PixelSearch( &FoundX, &FoundY, 177, 160, 188, 130, 0xB48C0C,5){
    return true
    }
  else
    return false
}

CheckIfMaxFatigue(){
 if PixelSearch( &FoundX, &FoundY, 120, 160, 127, 130, 0xB48C0C,10){
    return true
    }
  else
    return false
}

CheckIfMaxFood(){
 if PixelSearch( &FoundX, &FoundY, 215, 150, 208, 160, 0x9B6904,10){
    return true
    }
  else
    return false
}
;; 163, 150, 150, 160, normal values
;; 180, 150, 178, 160, testing values
CheckIfMinFood(){
 if PixelSearch( &FoundX, &FoundY, 180, 150, 178, 160,  0x9B6904,5){
    return false
    }
  else
    return true
}

webhook := ""
thumbnail := AttachmentBuilder( "egghead.png")
;HUNGY COORDS
;MAX 215, 157, 208, 147
;MIN 163, 157, 150, 147
EatFood(){
foundfood := false

if CheckIfMaxFood() == true{
    return
}
SendInput("``")
;; BURRITO FINDER!!!!
Burrito:="|<>FFFFFF-0.11$42.z000C00zU006k0lU000k0naNvrxwz6NvrxyzaNX6nblaNX6n3laNX6nbzbtX6xyz7tX6RyU"
CheapSandwich:="|<>FFFFFF-0.32$57.00wU0000000To000000030U0000000E7kwTDU0060zDnNy000k6961cE0020VTnx3000M490lcE003yVArRy000DY8wTjU0000000100000000080000000010000000000000000000000000000000S000201U47s000E080UU0002000461wy7qNcwywBbtynBDrts6l8Gx90l3Do/2LdM48P6VMHb90VzRo9iQtDoDlyV7nb8wVU"
BottledWater:="|<>FFFFFF-0.23$44.z000600zs0MlU07606AM01nXnzqS7zlyMljnzylaATBVlgBX7zMQP6Mls6DyTbjPwzz3ktqTDk00000000000000000000000000000000000000000000ln00000Awk30003DA0k000PqTTD7U6xbn7ts1ds6naM0SSTgza07biPA1U0tvyxyM8"
CheapIndomie:="|<>FFFFFF-0.14$49.0TA000000Tq000000A/000000C1yT7nw060zDnxy030NiM6lU1kAryzMk0MKT0tgs0DvCzTrs03xbTbvw0000001U0000000k0000000M0000000000000000000000000300C000Q1U0600060k0300000NyDblxtjgzDnwzwryNiP7NaTDAqBVgnDzaT6lqNbUnCzDnAnTtbTrlaNjs"

if (ok:=FindText(&X, &Y, 0, 0, 800, 800, 0, 0, Burrito))
{
    foundfood := true
    FindText().Click(X, Y+8, "L")
}else if (ok:=FindText(&X, &Y, 0, 0, 800, 800, 0, 0, CheapSandwich)) {
    foundfood := true
    FindText().Click(X, Y+8, "L")
}else if (ok:=FindText(&X, &Y, 0, 0, 800, 800, 0, 0, BottledWater)) {
    foundfood := true
    FindText().Click(X, Y+8, "L")
}else if (ok:=FindText(&X, &Y, 0, 0, 800, 800, 0, 0, CheapIndomie)) {
    foundfood := true
    FindText().Click(X, Y+8, "L")
}

;; CHEAP SANDWICH FINDER


if foundfood == true {

Sleep(300)
SendInput("``")
Loop{
    if CheckIfMaxFood() == true{
        break
    }
    Click(403,310)
    Sleep(400)
}until CheckIfMaxFood() == true
foundfood := false
return true

}else {
;; out of food webhook goes here! (could make it leave the game)
return true
}









}
MachineFarm(){
  farming := true
  global loopcount
  startfarm := A_TickCount

  Loop{
    if ChosenStam.Value == 1 {
     if CheckIfMinStamina() == true {
     Loop   {
        Sleep(10)
        if (A_TickCount - startfarm >  65000){
        Sleep(500)
        break
        }
     } until CheckIf25Stamina() == true


    }
    }else if ChosenStam.Value == 2 {
        if CheckIfMinStamina() == true {
     Loop   {
        Sleep(10)
        if (A_TickCount - startfarm >  65000){
        Sleep(500)
        break
        }
     } until CheckIf50Stamina()

    }
}else if ChosenStam.Value == 3 {
        if CheckIfMinStamina() == true {
     Loop   {
        Sleep(10)
        if (A_TickCount - startfarm >  65000){
        Sleep(500)
        break
        }
     } until CheckIfMaxStamina()

    }
}
    if (A_TickCount - startfarm >  65000){
        Sleep(500)
        if CheckIfMaxFatigue() == false {
            StartMachine()
        }

        break
    }

    ;W detection
    Text:="|<>FFFFFF-323232$57.0000000001z003y007yDs00zs00zVz007z00DwDs01zs01z1zU0Dz00TsDw03zs03y1zU0Tz00zU7w07zs07w0zU0zz01z07w0Dzw0Ds0zU1zzU3y07w0Trw0zk0zk3yzU7w07y0zbw1zU0TkDszUDs03y1z3w3z00TkTkTUTk03y3y3w7y00TkzUTkzU03y7w3yDw00Ttz0Tlz003zDs3yTs00Dvy0Dny001zzk1yzU00Dzw0Dzw001zzU1zz000Dzs0Dzs001zy01zy000Dzk0Dzk001zw01zw0007zU07zU000zs00zs0007z007z0000zk00zk000000000000U"

    if (ok:=FindText(&X, &Y, 0, 0, 800, 800, 0, 0, Text))
    {
      SendInput("w")
    }
    ; A detection

    Text:="|<>FFFFFF-323232$41.000000000000000007y00000Tw00000zw00003zs0000Dzk0000TzU0001zz00007zz0000Dvy0000zbw0003y7s0007wDs000TkTk001zUzU003y0z000Ds1z000Tk3y001z07w007y0Ds00Ds0Ds00zk0zk03zzzzU07zzzz00Tzzzz01zzzzy03zzzzw0Dw00Ds0zk00Ts1z000Tk7y000zUTs001z0zk003z3z0003y7w0007w0000001"

    if (ok:=FindText(&X, &Y, 0, 0, 800, 800, 0, 0, Text))
    {
      SendInput("a")
    }
    ; D detection

    Text:="|<>FFFFFF-323232$41.000000000000000zzzs001zzzy003zzzz007zzzz00Dzzzz00zzzzz01zU0zz03y00Dy07w00Dw0Ds00Dw0zk00Ts1zU00Tk3y000zU7w001z0Ds003y0zk007w1zU00Ds3y000Tk7w001zUDs003z0zk007w1zU00Ts3y001zk7w003z0Ds00Dy0zk01zs1zU07zU3z03zy07zzzzs0DzzzzU0zzzzy01zzzzk03zzzw007zzy0000000001"

    if (ok:=FindText(&X, &Y, 0, 0, 800, 800, 0, 0, Text))
    {
     SendInput("d")
    }
    ; S detection

    Text:="|<>FFFFFF-323232$34.000000007y0007zzU01zzzk0Dzzz03zzzw0DzzzU1zs3y0Dy00k0zk0003y0000Ds0000zU0003z0000Dy0000zz0001zzU007zzk00Dzzk00Dzzk00DzzU007zy0003zw0001zk0003z00007w0000Tk2003z0S00Ds1y03zUDzzzw0zzzzk7zzzy0DzzzU07zzw003zy00000002"

    if (ok:=FindText(&X, &Y, 0, 0, 800, 800, 0, 0, Text))
    {
      SendInput("s")
    }


  } until CheckIfMaxFatigue() == true
    MaxFatigueAlert()

}
; 304, 371, 503, 568, 0x41F6AA
; FIX THIS SHIT ITS BROKEN ON THE BUYING FOR SOME FUCKING REASON IDK MAN !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
TechniqueFarm(){
    global loopcount
    while true {
    Send "{d down}"
    Sleep(1600)
    Send "{d up}"
    if PixelSearch( &FoundX, &FoundY, 304, 371, 503, 568, 0x64FAC2,10){
        MouseMove(FoundX,FoundY+4)
        Click(FoundX,FoundY+4)
        MouseMove(FoundX,FoundY+8)
        Click(FoundX,FoundY+8)
        Click()
        Click()
        Click()
        MouseMove(FoundX,FoundY+4)
        Click()
        Click()
        Click()




    }else{
        Click()
        Click()
        Click()
        Click()
        Click()
        Click()
    Click(396,461)
    Click(475,461)
    Click(396,461)
    }
    Sleep(1000)
    Send "{d down}"
    Sleep(3150)
    Send "{d up}"
    Sleep(100)
    Send "{w down}"
    Sleep(1200)
    Send "{w up}"



    Text:="|<>E2E2E2-0.58$48.y0000800n0002000lU006000lfC7jcwSliPAa9Ynz818690Xk8T8690zk8F8690Uk8HgW9Ymk8RbXcwSU"


    if (ok:=FindText(&X, &Y, 0, 0, 800, 800, 0, 0, Text))
    {
        ;403 310
        ;25 times
      MouseMove(X,Y+3)
      FindText().Click(X, Y, "L")
      Sleep(100)
      Click(403,310)
      Sleep(50)
      Click(403,310)
    }else
        MsgBox("No technique found")
    Sleep(200)
    SendInput("1")
    Sleep(500)
    Loop 25 {
        Click()
        Sleep(1150)
    }
    SendInput("1")
    Send "{s down}"
    Sleep(1200)
    Send "{s up}"
    Sleep(100)
    Send "{a down}"
    Sleep(4800)
    Send "{a up}"
    Sleep(200)
    Send "{w down}"
    Sleep(1000)
    Send "{w up}"
}
}
; 308, 477

StartMachine(){
    global loopcount
    if CheckIfMaxFatigue() == true {
        if UseWebhook.Value == 1{
            MaxFatigueAlert()
        }
        return
    }
    if CheckIfMinFood() == true {
        Loop{

        Sleep(100)
        } until EatFood() == true

    }
    loopcount := loopcount + 1
    LoopCountAlert()
    Send "{e down}"
    Sleep(3000)
    Send "{e up}"
    Sleep(200)
    if MachineSide.Value == 2{
    MouseMove(484, 357)
    MouseMove(481, 351)
    }else if MachineSide.Value == 1{
    MouseMove(314, 360)
    MouseMove(305, 363)

    }
    Click()
    Sleep(200)
    Loop ChosenSlot.Value-1{
        MouseMove(555,364)
        MouseMove(550,360)
        Click()
        Sleep(200)
    }

    MouseMove(308, 477)
    MouseMove(305, 475)


    Loop{
     Sleep(100)
    }until CheckIfMaxStamina() == true
    MouseMove(308, 477)
    MouseMove(305, 475)
    Click()

    MachineFarm()
}




; #dba60a
BedFarm(){
    Loop {
        Sleep(100)
        Click(40,206)
    }until CheckIfMinFatigue() == true

    if CheckIfMaxFatigue() == true{
        if UseWebhook.Value == 1{
                MaxFatigueAlert()
            }
        return
    }else {
        if UseWebhook.Value == 1{
                embed := EmbedBuilder()
                webhook := Discord.Webhook(DiscordWebhook.Value)
                embed.setTitle("Starting Tool Farm!")
                embed.setDescription("")
                embed.setAuthor({name:"Egghead's Macro",icon_url:thumbnail.attachmentName})
                embed.setColor(0xFFFFFF)
                embed.addFields([
                   {
                      name:"Starting tool farm!.",
                      value: ""
                   },

                ])
                webhook.send({
                      embeds: [embed],
                     files: [thumbnail]
                })

        }

    }


    MouseMove(408,330)
    MouseMove(405,333)
    Click(408,330)
        ;Squat Detection
   ; Text:="|<>FFFFFF-323232/989898-323232$41.S000001y0000k200001U60yEXrrj3AVBaBbY921gM3MG4zMw6EYN6kDQrBmRUHkuDbNrU040000008000000E0001"
    ;Pushups Detection


    if ChosenSlot2.Value == 2 {
         Text:="|<>*126$51.1zzxzzzztbzzjzzzzCTzxzzzztmxlcvqXlSrggnSnAc6xbjPqxbDriBvSri9yxwjPqxwDnBZvAnBVz5VjQK3VzzzzzzrzzzzzzzyzzU"

       if (ok:=FindText(&X, &Y, 0, 0, 800, 800, 0, 0, Text))
        {
          MouseMove(X,Y+3)
          Sleep(300)
          FindText().Click(X, Y, "L")
          MouseMove(408,330)
        }

        Loop {
        Click(408,330)
        }until CheckIfToolFatigue() == true
        if UseWebhook.Value == 1{
            MaxFatigueAlert()
        }
        SendInput("1")
        Sleep(100)
        SendInput("1")
        MouseMove(408,330)
        MouseMove(405,333)
        Click(408,330)

    }else if ChosenSlot2.Value == 1 {
         Text:="|<>FFFFFF-323232/989898-323232$41.S000001y0000k200001U60yEXrrj3AVBaBbY921gM3MG4zMw6EYN6kDQrBmRUHkuDbNrU040000008000000E0001"

        if (ok:=FindText(&X, &Y, 0, 0, 800, 800, 0, 0, Text))
        {
          MouseMove(X,Y+3)
          Sleep(300)
          FindText().Click(X, Y, "L")
          MouseMove(408,330)
        }

        Loop {
        Click(408,330)
        }until CheckIfToolFatigue() == true
        if UseWebhook.Value == 1{
            MaxFatigueAlert()
        }
        SendInput("1")
        Sleep(100)
        SendInput("1")
        MouseMove(408,330)
        MouseMove(405,333)
        Click(408,330)
    }
}







if FileExist(A_ScriptDir "\SaveFile.ini"){
} else {
  FileAppend(
    "[General]n"



    ,SaveFile,"UTF-16-RAW")

    ; leave on death saving
    IniWrite("0",SaveFile, "General", "leave_on_death")
    IniWrite("0",SaveFile, "General", "shutdown_on_death")

    ;auto eat saving
    ;webhook saving

    IniWrite("0",SaveFile, "General", "discord_webhook")
    ;use webhook
    IniWrite("0",SaveFile, "General", "use_webhook")
}


if IniRead(SaveFile,"General","leave_on_death") == 0 or  IniRead(SaveFile,"General","leave_on_death") == 1
{
    LeaveOnDeath.Value := IniRead(SaveFile, "General", "leave_on_death")
    ShutdownOnDeath.Value := IniRead(SaveFile, "General", "shutdown_on_death")

    UseWebhook.Value := IniRead(SaveFile, "General", "use_webhook")
    DiscordWebhook.Value :=  IniRead(SaveFile, "General", "discord_webhook")




}
;Save button logic
save_Button_Click(btn,info)
{
    ; leave on death saving
    IniWrite(ControlGetChecked(LeaveOnDeath),SaveFile, "General", "leave_on_death")
    IniWrite(ControlGetChecked(ShutdownOnDeath),SaveFile, "General", "shutdown_on_death")

    ;auto eat saving
    ;webhook saving
    IniWrite(ControlGetText(DiscordWebhook),SaveFile, "General", "discord_webhook")
    ;use webhook
    IniWrite(ControlGetChecked(UseWebhook),SaveFile, "General", "use_webhook")

  ;  MsgBox(IniRead(SaveFile,"General","Leave_on_death"))
 ;  FileAppend("Leave_on_death = " ControlGetChecked(LeaveOnDeath) . "n" . "Auto_eat = " ControlGetChecked(AutoEat) . "n" . "Discord_webhook = " . ControlGetText(DiscordWebhook) , SaveFile)
}
LastAction := A_TickCount



startready_Button_Click(btn,info){

    OptionsGui.Hide()
    if WinExist("Roblox")
    {
    WinActivate("Roblox")

    WinGetPos ,, &Width, &Height, "Roblox"
    WinMove  0,0 ,0,0, "Roblox"
    }
    if PreferredItem.Value == 1 {
        StartMachine()

    }else if PreferredItem.Value == 3 {
        BedFarm()
    }

}


startfarm_Button_Click(btn, info)
{
  global dothing
  global LastAction
  global checking
  global webhook
  LastAction := A_TickCount
    if WinExist("Roblox")
    {
    WinActivate("Roblox")

    WinGetPos ,, &Width, &Height, "Roblox"
    WinMove  0,0 ,0,0, "Roblox"


    }
    ;RejoinGame()
    ;CheckInv("Platinum")
    if PreferredItem.Value == 1 {

        MyGui.Hide()
        dothing := false

        MachineSide2.Visible := false
        ChosenSlot2.Visible := false
        OptionsGui.Show("w300 h400")



    }else if PreferredItem.Value == 4 {
        TechniqueFarm()
    }else if PreferredItem.Value == 3 {
        MyGui.Hide()
        dothing := false
        MachineSide.Visible := false
        ChosenSlot.Visible := false
        ChosenStam.Visible := false

        OptionsGui.Show("w300 h400")
    }



        if UseWebhook.Value == 1{
        webhook := Discord.Webhook(DiscordWebhook.Value)
        }










}

#Requires AutoHotkey v2.0

envPath := A_ScriptDir "\.env"
vars := Map()  ; mejor usar Map() en v2

if FileExist(envPath)
{
    content := FileRead(envPath, "UTF-8")
    for line in StrSplit(content, "`n")
    {
        line := Trim(line, "`r `t ")
        
        if (line = "" || SubStr(line, 1, 1) = "#")
            continue

        pos := InStr(line, "=")
        if (pos <= 1)  ; evita claves vacías
            continue

        key := Trim(SubStr(line, 1, pos-1))
        value := Trim(SubStr(line, pos+1))

        if (key != "")
            vars[key] := value
    }
}
else
{
    MsgBox "No se encontró el archivo .env en: " envPath
}

GetEnv(key){
    global vars
    return vars.Has(key) ? vars[key] : ""
}

; Para debug
; MsgBox GetEnv("EMAIL")

::@@@:: {
    Send GetEnv("EMAIL_SECUNDARIO")
}

::@@:: {
    Send GetEnv("EMAIL")
}

::092:: {
    Send GetEnv("PHONE")
}

:*:@nom:: {
    Send GetEnv("NAME")
}

:*:556:: {
    Send GetEnv("CI")
}
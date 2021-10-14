unit my_units;

{$mode objfpc}{$H+}

interface

uses
  Windows, Classes, SysUtils, ShellApi, Process, Dialogs;

procedure RunShellExecute(const CommandPath,params:string);
procedure RunAsAdmin(const Handle: Hwnd; const CommandPath, Params: string);
function GettheHostName: string;
procedure RunACommans(const CommandPath: string; Params: array of string);

implementation

procedure RunShellExecute(const CommandPath,params:string);
begin
  //  ( Handle, nil/'open'/'edit'/'find'/'explore'/'print',   // 'open' isn't always needed
  //      path+prog, params, working folder,
  //        0=hide / 1=SW_SHOWNORMAL / 3=max / 7=min)   // for SW_ constants : uses ... Windows ...
  if ShellExecute(0,'runas',PChar(CommandPath),PChar(params),PChar(extractfilepath(CommandPath)),1) >32 then; //success
  // return values 0..32 are errors
end;

procedure RunAsAdmin(const Handle: Hwnd; const CommandPath, Params: string);
{var
  sei: TShellExecuteInfoA;}
begin
  { FillChar(sei, SizeOf(sei), 0);
  sei.cbSize := SizeOf(sei);
  sei.Wnd := Handle;
  sei.fMask := SEE_MASK_FLAG_DDEWAIT or SEE_MASK_FLAG_NO_UI;
  sei.lpVerb := 'runas';
  sei.lpFile := PAnsiChar(Path);
  sei.lpParameters := PAnsiChar(Params);
  sei.nShow := SW_SHOWNORMAL;
  Result := ShellExecuteExA(@sei);}
  ShellExecute(Handle, 'runas', PChar(CommandPath), PChar(Params), nil, SW_SHOWNORMAL);   // This one works as admin
end;
function GettheHostName: string;
var
  computerNameBuffer: array[0..255] of char;
  sizeBuffer: DWord;
begin
  SizeBuffer := 256;
  getComputerName(computerNameBuffer, sizeBuffer);
  result := string(computerNameBuffer);
end;

procedure RunACommans(const CommandPath: string; Params: array of string);
var
   AProcess: TProcess;
   i: integer;

begin
   AProcess := TProcess.Create(nil);
   showmessage(inttostr(Length(Params)));
   AProcess.CommandLine := CommandPath;
   for i:=0 to Length(Params)-1 do begin
       showmessage(Params[i]);
       AProcess.Parameters.Add(Params[i]);
   end;
   //AProcess.StartupOptions:=[suoUseShowWindow];
   //AProcess.Options := AProcess.Options + [poUsePipes];
   //AProcess.Execute;
   AProcess.Free;
end;

end.


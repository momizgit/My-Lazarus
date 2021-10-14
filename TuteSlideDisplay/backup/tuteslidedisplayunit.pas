unit TuteSlideDisplayUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TTuteSlideDisplayBoard }

  TTuteSlideDisplayBoard = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    procedure FollowMouse(X, Y: Integer);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure Label1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private

  public

  end;

var
  TuteSlideDisplayBoard: TTuteSlideDisplayBoard;
  FollowMouse_x,FollowMouse_y:integer;
  IsMouseDown:boolean;

implementation

{$R *.lfm}
procedure TTuteSlideDisplayBoard.FollowMouse(X, Y: Integer);
begin
  If (IsMouseDown) then SetBounds(Left + (X - FollowMouse_x),Top +(Y - FollowMouse_y),Width, Height);
end;

procedure TTuteSlideDisplayBoard.FormMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     FollowMouse_x:=X;
     FollowMouse_y:=Y;
     IsMouseDown:=True;
end;

procedure TTuteSlideDisplayBoard.FormMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
   FollowMouse(X,Y);
end;

procedure TTuteSlideDisplayBoard.FormMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   IsMouseDown:=False;
end;

procedure TTuteSlideDisplayBoard.Image1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     FollowMouse_x:=X;
     FollowMouse_y:=Y;
     IsMouseDown:=True;
end;

procedure TTuteSlideDisplayBoard.Image1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  FollowMouse(X,Y);
end;

procedure TTuteSlideDisplayBoard.Image1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   IsMouseDown:=False;
end;

procedure TTuteSlideDisplayBoard.Label1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FollowMouse_x:=X;
  FollowMouse_y:=Y;
  IsMouseDown:=True;
end;

procedure TTuteSlideDisplayBoard.Label1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  FollowMouse(X,Y);
end;

procedure TTuteSlideDisplayBoard.Label1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IsMouseDown:=False;
end;

end.


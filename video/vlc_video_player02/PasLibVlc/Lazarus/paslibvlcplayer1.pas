unit PasLibVlcPlayer1;

{$mode delphi}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, PasLibVlcPlayerUnit;

type
  TPasLibVlcPlayer1 = class(TPasLibVlcPlayer)
  private

  protected

  public

  published

  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('PasLibVlc',[TPasLibVlcPlayer1]);
end;

end.

unit main;

{$mode delphi}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Grids, RTTIGrids, Utils.Cep, fpjson;

type

  { TFrmlViaCep }

  TFrmlViaCep = class(TForm)
    BtnBuscar: TButton;
    EdtCep: TEdit;
    ImgBg: TImage;
    GridCep: TStringGrid;
    procedure BtnBuscarClick(Sender: TObject);
    procedure EdtCepKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure EdtCepKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
  public
    procedure Search();
  end;

var
  FrmlViaCep: TFrmlViaCep;

implementation

{$R *.lfm}

{ TFrmlViaCep }

procedure TFrmlViaCep.EdtCepKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Search();
    Exit;
  end
  // A primeira parte valida se é apenas números e a segunada permite teclas como arrows, backspace e del
  else if not ((Key in [48..57, 96..105]) or (Key in [08, 147, 37..40])) then
    Key := 0;
end;

procedure TFrmlViaCep.BtnBuscarClick(Sender: TObject);
begin
  Search();
end;

procedure TFrmlViaCep.EdtCepKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
var
  Cep: string;
begin
  Cep := DesformatarCep(EdtCep.Text);
  EdtCep.Text := FormatarCep(Cep);
end;

procedure TFrmlViaCep.FormShow(Sender: TObject);
begin
  GridCep.RowCount := 7;
  GridCep.ColCount := 2;
  GridCep.DefaultColWidth := Trunc(GridCep.Width / 2.05);
  GridCep.Visible := False;
end;


procedure TFrmlViaCep.Search();
var
  Cep: string;
  Resposta: TJSONObject;
begin
  Cep := DesformatarCep(EdtCep.Text);

  if Length(Cep) < 8 then
  begin
    ShowMessage('O Cep informado é invalido!');
    Exit;
  end;

  try
    Resposta := BuscarCep(Cep);

    try
      GridCep.Cells[0, 0] := 'Campo';
      GridCep.Cells[1, 0] := 'Valor';

      GridCep.Cells[0, 1] := 'CEP';
      GridCep.Cells[1, 1] := Resposta.Get('cep', '');

      GridCep.Cells[0, 2] := 'Longraduro';
      GridCep.Cells[1, 2] := Resposta.Get('logradouro', '');

      GridCep.Cells[0, 3] := 'Complemento';
      GridCep.Cells[1, 3] := Resposta.Get('complemento', '');

      GridCep.Cells[0, 4] := 'Bairro';
      GridCep.Cells[1, 4] := Resposta.Get('bairro', '');

      GridCep.Cells[0, 5] := 'Cidade';
      GridCep.Cells[1, 5] := Resposta.Get('localidade', '');

      GridCep.Cells[0, 6] := 'Estado';

      if Resposta.Get('estado', '') <> '' then
        GridCep.Cells[1, 6] := Resposta.Get('estado', '') + ' - ' +
          Resposta.Get('uf', '') + ' - ' + Resposta.Get('regiao', '');


      GridCep.Visible := True;
    finally
      Resposta.Free;
    end;
  except
    on ex: Exception do
      ShowMessage(ex.Message);
  end;
end;

end.

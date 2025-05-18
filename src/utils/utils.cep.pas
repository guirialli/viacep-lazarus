unit utils.cep;

{$mode delphi}{$H+}

interface

uses
  Classes, SysUtils, StrUtils, fpjson, jsonparser;

function FormatarCep(const Cep: string): string;
function DesformatarCep(const Cep: string): string;
function BuscarCep(const Cep: string): TJSONObject;

implementation

uses RESTRequest4D;

function FormatarCep(const Cep: string): string;
begin
  Result := Cep;

  if Length(Cep) = 8 then
    Result := Copy(Cep, 1, 5) + '-' + Copy(Cep, 6, 3);
end;

function DesformatarCep(const Cep: string): string;
var
  I: integer;
begin
  Result := '';
  for i := 1 to Length(CEP) do
  begin
    if CEP[i] in ['0'..'9'] then
      Result := Result + CEP[i];
  end;
end;

function BuscarCep(const Cep: string): TJSONObject;
const
  url = 'https://viacep.com.br/ws/%s/json/';
var
  LResponse: IResponse;
  JsonStr: string;
  JsonData: TJSONData;
begin
  LResponse := TRequest.New.BaseURL(Format(url, [Cep])).Get;

  if LResponse.StatusCode <> 200 then
    raise Exception.Create('Cep Invalido!');

  JsonStr := LResponse.Content;
  JsonData := GetJSON(JsonStr);

  if JsonData.JSONType <> jtObject then
    raise Exception.Create('Erro ao converter o CEP!');

  Result := TJSONObject(JsonData);
end;

end.

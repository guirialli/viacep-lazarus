# ViaLazarus

Um pequeno programa feito em **Lazarus** que consome a API do [ViaCEP](https://viacep.com.br/) e exibe os dados de endereço a partir de um CEP informado.

## 🔍 Funcionalidade

Este projeto realiza uma requisição REST para a API do ViaCEP e extrai os dados de endereço (rua, bairro, cidade, estado, etc.), exibindo-os na interface gráfica feita em Lazarus.

## 📦 Requisitos

- [Lazarus IDE](https://www.lazarus-ide.org/)
- [RESTRequest4Delphi](https://github.com/viniciusfbb/RESTRequest4Delphi)

## ✅ Como usar

1. Clone o repositório ou baixe os arquivos do projeto.
2. Abra o projeto `.lpi` no Lazarus.
3. Certifique-se de que o **RESTRequest4Delphi** está instalado e adicionado ao projeto.
4. Compile e execute.

## 🧱 Estrutura

- Interface gráfica feita com componentes padrão do Lazarus.
- Requisições REST feitas com `TRESTClient`, `TRESTRequest` e `TRESTResponse`.

## 📬 Exemplo de uso

Digite o CEP no campo correspondente e clique em "Pesquisar". Os dados serão preenchidos automaticamente:

```text
CEP: 01001-000  
Logradouro: Praça da Sé  
Bairro: Sé  
Cidade: São Paulo  
Estado: SP

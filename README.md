### DataTables API

Esse widget foi feito inspirado no DataTables (https://datatables.net/) para criar tabelas dinamicas dentro do Flutter com dados vindo de APIs


# Como Usar

Chame o widget `DataTablesAPI` 

```javascript

 DataTables(
            headers: {"Autorization": "Barear 123"},
            url:  Uri.parse("link_da_api"),
            fields: [
              FieldsDataTables(label: "ID", id: "id"),
              FieldsDataTables(label: "Nome", id: "razao_social"),
              FieldsDataTables(label: "Código Loja", id: "codempresa"),
              FieldsDataTables(
                  label: "Ação",
                  child: (var valor) {
                    return Column(children: [Text("Teste - " + valor['id'].toString())]);
                  }),
            ])
```

O campo `url` e o `fields`  são obrigatorios o `headers` é opicional, veja o que cada um espera
`url` : a URL de onde irá buscar os dados em forma de URI
`fields` : uma lista de `FieldsDataTables` com as informações dos campos
`headers`  : um Map com headers para passar na requisição

**FieldsDataTables**
FieldsDataTables é uma classe onde passamos os dados que iremos buscar no nosso servidor
```javascript
	FieldsDataTables(
		label: "label",
		id: "id"
		name: "name"
		search: true
		order true
		child: Widget Function(Map map)
		),
```
`label` : Como irá aparecer no header da tabela
`id` : campo que esse elemento tem no banco de dados
`name` : nome do campo que irá chamar no retorno do JSON
`search` : Se esse campo vai entrar na busca
`order` :  Se esse campo poderá ser ordenado
`child`: Caso sejá necessário trabalhar as informações recebidas para criar um Widget, ele espera um function com retorno de Widget, usando por exemplo para criar um botão de editar

**Requisição ao servidor**

O Widget utiliza a biblioteca HTTP para fazer suas requisição e sempre que faz uma requisição ela adiciona os seguindes queryParametrs
`page`  : A página atual, começando de 1
`limit` : A quantidade de dados por página
`fields` : Todos os campos que estão no ID ou no name (caso não tenha ID) separados por virgula

Exemplo de URL de requisição: http://localhost/api/loja?page=3&fields=id%2Crazao_social%2Ccodempresa&limit=2

**Retorno da requisição**

O Widget sempre espera um JSON com os seguintes campos

```
{
	"pages":3,
	"page":"3",
	"count":6,
	"limit":"2",
	"data":[
		{
			"id":5,
			"razao_social":"5",
			"codempresa":"5"
		},
		{
			"id":6,
			"razao_social":"6",
			"codempresa":"6"
		}
	]
}
```

`pages`  : A quantidade total de paginas
`limit` : A quantidade de dados por página (Não Obrigatorio)
`page` : A página atual (Não Obrigatorio)
`count` : A quantidade total de dados
`data` : Um Array com os campos solicitados

**Funcionalidades em desenvolvimento**
- [ ] Criar campo de busca
- [ ] Criar ordenação
- [ ] Criar páginação numero de páginas





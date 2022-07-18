# ifchunicamp
Este pacote visa a alterar a capa e a folha de rosto da classe abnTeX2
de modo a ficarem compatíveis com as normas para Dissertações e Teses do IFCH/Unicamp.
A norma consultada é a versão versão 30/2020, disponível
[no site do IFCH/Unicamp](https://www.ifch.unicamp.br/ifch/pos/formularios) (acesso em 19/02/2020).

Esta customização da classe abnTeX2 procura seguir as diretrizes especificadas
[aqui](https://github.com/abntex/abntex2/wiki/ComoCustomizar).

Para utilizar este pacote em seu documento LaTeX, adicione ao seu prêambulo
`\usepackage{ifchunicamp}`
se quiser colocar o logo da Unicamp no canto superior esquerdo da capa;
adicione
`\usepackage[semlogo]{ifchunicamp}`
se não quiser o logo.

Caso use a opção padrão, com logo,
você precisa fornecer um arquivo chamado `logo.pdf`.
Sugiro criá-lo baixando um dos vários formatos de imagem disponíveis
[no site da universidade](https://www.unicamp.br/unicamp/logotipo)
e convertendo-o para `pdf`.
Esse arquivo `logo.pdf` deve estar ou no mesmo diretório que o arquivo `.tex` a ser compilado, ou
em um diretório especificado pelo comando `\graphicspath` do pacote `graphicx`.
Por exemplo, se o arquivo `.tex` a ser compilado está em `/home/user/` e `logo.pdf` está em `/home/user/images/`,
pode-se colocar o seguinte comando no preâmbulo do arquivo `.tex`, após `\usepackage{graphicx}`:
`\graphicspath{{images/}}`
Observe as duplas chaves!
Mais informações podem ser encontradas
[no CTAN](https://www.ctan.org/pkg/graphicx).

Dúvidas podem ser enviadas a `daniel_asl_diniz <at> protonmail.com`.

===========
ifchunicamp
===========

Este pacote visa a alterar
a capa e a folha de rosto da classe abnTeX2
de modo a ficarem compatíveis com
as normas para Dissertações e Teses do IFCH/Unicamp.
A norma consultada é a
versão 42/2022,
disponível
`no site do IFCH/Unicamp
<https://www.ifch.unicamp.br/ifch/pf-ifch/public-files/pos/formularios/manual_defesa_v44_2022.pdf>`_
(acesso em 28/09/2022).

Esta customização da classe abnTeX2 procura seguir as diretrizes especificadas
`aqui <https://github.com/abntex/abntex2/wiki/ComoCustomizar>`_.

Para utilizar este pacote em seu documento abnTeX2, adicione ao seu prêambulo
a linha
``\usepackage{ifchunicamp}``.
Estão disponíveis as seguintes opções
(especificadas entre colchetes, logo após o comando
``\usepackage`` e antes de ``{``):

* ``semlogo``:
  para omitir o logo da Unicamp no canto superior esquerdo da capa;
* ``naofinal``:
  para omitir o bloco de texto na
  folha de rosto
  que identifica o trabalho como versão final.
* ``peloaluno={pela aluna}``
  (observe que "pela aluna" está entre chaves!):
  para substituir a expressão
  "pelo aluno" no
  bloco de texto de versão final pela expressão
  "pela aluna".

Essas opções podem ser combinadas com vírgulas.
Por exemplo:

* ``\usepackage[semlogo,naofinal]{ifchunicamp}``:
  omite o logo e também o bloco de texto de versão final.
* ``\usepackage[peloaluno={pelx alunx}]{ifchunicamp}``:
  substitui a expressão "pelo aluno" por "pelx alunx".


Mais informações sobre o logo
-----------------------------
Caso use a opção padrão, com logo,
você precisa fornecer um arquivo chamado ``logo.pdf``.
Sugiro criá-lo baixando um dos vários formatos de imagem disponíveis
`no site da universidade
<https://www.unicamp.br/unicamp/logotipo>`_
e convertendo-o para ``pdf``.
Esse arquivo ``logo.pdf`` deve estar ou no mesmo diretório do arquivo ``.tex`` a ser compilado, ou
em um diretório especificado pelo comando ``\graphicspath`` do pacote ``graphicx``.
Por exemplo, se
o arquivo ``.tex`` a ser compilado está em ``~/Documents`` e
``logo.pdf`` está em ``~/Documents/figuras``,
pode-se colocar o seguinte comando no preâmbulo do arquivo ``.tex``,
após ``\usepackage{graphicx}``:
``\graphicspath{{figuras/}}``.
Observe as duplas chaves!
Mais informações podem ser encontradas
`no CTAN <https://www.ctan.org/pkg/graphicx>`_.


Mais informações sobre o bloco de versão final
----------------------------------------------
O bloco de texto controlado pela opção ``naofinal``
contém a seguinte frase:

   ESTE EXEMPLAR CORRESPONDE À VERSÃO FINAL DA TESE DEFENDIDA
   PELO ALUNO <NOME DO ALUNO>
   ORIENTADA POR <NOME DO ORIENTADOR>.

O campo ``<NOME DO ALUNO>`` é especificado pela macro de abnTeX2
``\autor``,
e o campo ``<NOME DO ORIENTADOR>``, pela macro
``\orientador``.

Por exemplo,
o código abaixo::

    \usepackage{ifchunicamp}
    \titulo{Provisório}
    \subtitulo{provisório}
    \autor{Fulano da~Silva}
    \orientador[Orientadora]{Profa. Dra. Beltrana Lopes}

imprimiria o seguinte bloco de versão final:

   ESTE EXEMPLAR CORRESPONDE À VERSÃO FINAL DA TESE DEFENDIDA
   PELO ALUNO FULANO DA SILVA
   ORIENTADA POR PROFA. DRA. BELTRANA LOPES.


Dúvidas podem ser enviadas a ``daniel_asl_diniz <at> protonmail.com``.

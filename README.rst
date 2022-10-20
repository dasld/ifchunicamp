===========
ifchunicamp
===========

Este pacote altera a capa e a folha de rosto da classe abnTeX2
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

Para utilizar este pacote em seu documento abnTeX2,
adicione ao seu prêambulo a linha
``\usepackage{ifchunicamp}``.
Ela precisa vir **após** a linha ``\documentclass{abntex2}``!
Este pacote só pode ser usado com a classe abnTeX2.
Estão disponíveis as seguintes opções
(especificadas entre colchetes,
logo após a expressão
``\usepackage`` e antes de ``{``):

* ``logo={}``:
  especifica o arquivo entre chaves como
  aquele contendo o logo da Unicamp;
* ``semlogo``:
  omite o logo da Unicamp no canto superior esquerdo da capa;
* ``naofinal``:
  omite o bloco de texto na folha de rosto
  que identifica o trabalho como versão final;
* ``peloaluno={}``:
  substitui a expressão "pelo aluno"
  no bloco de texto de versão final
  pela expressão entre chaves;
* ``trabalho={}``:
  substitui a palavra "tese"
  no bloco de texto de versão final
  pela expressão entre chaves.

Essas opções podem ser combinadas com vírgulas.
Por exemplo:

* ``\usepackage[semlogo,naofinal]{ifchunicamp}``:
  omite o logo e também o bloco de texto de versão final.
* ``\usepackage[peloaluno={pelx alunx}]{ifchunicamp}``:
  substitui a expressão "pelo aluno" por "pelx alunx".
* ``\usepackage[logo={imagem.png},trabalho={dissertação}]{ifchunicamp}``:
  usa o arquivo ``imagem.png`` como logo da Unicamp, e
  substitui a expressão "tese" por "dissertção".

As opções "logo" e "semlogo" podem ser combinadas, mas
"sem logo" torna sem efeito a especificação do logo.

Mais informações sobre o logo
-----------------------------
Caso você não use a opção "sem logo" e
não especifique um arquivo com a opção "logo",
o pacote assume que existe, e utiliza, um arquivo chamado ``logo.pdf``.
Você pode criá-lo baixando um dos vários formatos de imagem disponíveis
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

   ESTE EXEMPLAR CORRESPONDE À VERSÃO FINAL DA <TIPO-DE-TRABALHO> DEFENDIDA
   PELO ALUNO <NOME DO ALUNO>
   ORIENTADA POR <NOME DO ORIENTADOR>.

O campo ``<TIPO-DE-TRABALHO>`` por padrão é "tese", mas
pode ser especificado pela opção ``trabalho={}``.
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

imprime o seguinte bloco de versão final:

   ESTE EXEMPLAR CORRESPONDE À VERSÃO FINAL DA TESE DEFENDIDA
   PELO ALUNO FULANO DA SILVA
   ORIENTADA POR PROFA. DRA. BELTRANA LOPES.

Já esse código::

    \usepackage[trabalho={monografia}]{ifchunicamp}
    \titulo{Provisório}
    \subtitulo{provisório}
    \autor{Fulano da~Silva}
    \orientador[Orientadora]{Profa. Dra. Beltrana Lopes}

imprime o seguinte bloco de versão final:

   ESTE EXEMPLAR CORRESPONDE À VERSÃO FINAL DA MONOGRAFIA DEFENDIDA
   PELO ALUNO FULANO DA SILVA
   ORIENTADA POR PROFA. DRA. BELTRANA LOPES.


Contato
-------
Dúvidas podem ser enviadas a
``daniel_asl_diniz <at> protonmail.com``.

===========
ifchunicamp
===========

Esta classe altera a capa e a folha de rosto da classe abnTeX2
de modo a ficarem compatíveis com
as normas para Dissertações e Teses do IFCH/UNICAMP.

As normas consultadas são o
`"Manual de defesa de dissertação/tese" do IFCH/UNICAMP <https://www.ifch.unicamp.br/ifch/pf-ifch/public-files/pos/formularios/manual_defesa_v47_2023.pdf>`_
e a
`"Instrução normativa CCPG Nº 002/2021" <https://www.ifch.unicamp.br/ifch/pf-ifch/public-files/pos/legislacao/insccpg002_2021.pdf>`_
(acesso em 30/08/2024).

Esta customização da classe abnTeX2 procura seguir as diretrizes especificadas
`aqui <https://github.com/abntex/abntex2/wiki/ComoCustomizar>`_.

Para utilizar esta classe em seu documento,
comece o prêambulo do seu documento com a linha
``\documentclass{ifchunicamp}``.
Você pode especificar as seguintes opções entre colchetes, logo após a expressão
``\documentclass`` e antes de ``{``):

* ``logo={}``:
  especifica o arquivo entre chaves como
  aquele contendo o logo da UNICAMP.
* ``alturadologo={}``:
  especifica a dimensão entre chaves como a altura do logo da UNICAMP. Recomendo
  que você não use essa opção. Se não usar, o logo terá a altura das linhas
  "UNIVERSIDADE ESTADUAL DE CAMPINAS/INSTITUTO DE FILOSOFIA E CIÊNCIAS HUMANAS".
* ``semlogo``:
  omite o logo da UNICAMP no canto superior esquerdo da capa.
* ``naofinal``:
  omite o bloco de texto na folha de rosto
  que identifica o trabalho como versão final.


Essas opções podem ser combinadas com vírgulas.
Por exemplo:

* ``\usepackage[semlogo, naofinal]{ifchunicamp}``:
  omite o logo e também o bloco de texto de versão final.
* ``\usepackage[logo={imagem.png}, naofinal]{ifchunicamp}``:
  usa o arquivo ``imagem.png`` como logo da UNICAMP, e
  omite o bloco de texto de versão final.

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
Se não tiver usado a opção ``naofinal``, você precisa informar um bloco de texto
de versão final.
Trata-se de uma frase como esta:

   ESTE EXEMPLAR CORRESPONDE À VERSÃO FINAL DA <TIPO-DE-TRABALHO> DEFENDIDA
   PELO(A) ALUNO(A) <NOME DO ALUNO>
   ORIENTADA POR <NOME DO ORIENTADOR>.

O comando ``\textodeversaofinal{...}`` registra a expressão entre chaves como o
texto de versão final.
Por exemplo,
o código abaixo::

    \documentclass{ifchunicamp}
    \titulo{Uma maravilhosa tese}
    \autor{Fulana da~Silva}
    \orientador[Orientadora]{Profa. Dra. Beltrana Lopes}
    \tipotrabalho{Tese (doutorado)}
    \textodeversaofinal{%
      Este trabalho corresponde à versão final da tese defendida pela aluna
      \imprimirautor,
      e orientada pela \imprimirorientador.%
    }

imprime o seguinte bloco de versão final:

   ESTE EXEMPLAR CORRESPONDE À VERSÃO FINAL DA TESE DEFENDIDA
   PELA ALUNA FULANA DA SILVA,
   E ORIENTADA POR PROFA. DRA. BELTRANA LOPES.


Contato
-------
Dúvidas podem ser enviadas a
``daniel_asl_diniz <at> protonmail.com``.

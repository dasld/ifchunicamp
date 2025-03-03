%%
%% Customizações do abnTeX2 (http://www.abntex.net.br/) para dissertações e teses do IFCH/Unicamp
%%
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%%
%% This work has the LPPL maintenance status `maintained'.
%%
%% The Current Maintainer of this work is Daniel Alves da Silva Lopes Diniz, diniz.cpm <at> gmail.com
%%
%% Further information about abnTeX2 are available on http://www.abntex.net.br/
%%

% ---
% INICIO DAS CUSTOMIZAÇÔES PARA O IFCH/UNICAMP
% ---
% Este pacote procura alterar a capa e a folha de rosto da classe abnTeX2 de modo a
% ficarem compatíveis com o "Manual de defesa de dissertação/tese" do IFCH/Unicamp, disponível em:
% https://www.ifch.unicamp.br/ifch/pf-ifch/public-files/pos/formularios/manual_defesa_v47_2023.pdf
% e com a "Instrução normativa CCPG Nº 002/2021", disponível em:
% https://www.ifch.unicamp.br/ifch/pf-ifch/public-files/pos/legislacao/insccpg002_2021.pdf
% (acesso em 06/04/2024).


% essa é a versão do LaTeX que provê \ProcessKeyOptions:
\NeedsTeXFormat{LaTeX2e}[2022-06-01]
% segundo o documento "LATEX2e for class and package writers", a data do pacote
% deve ser a primeira (ou única) informação no argumento opcional de \ProvidesPackage
% e vir no formato YYYY-MM-DD
\ProvidesClass{ifchunicamp}[2024-08-30]


% -- sistema do logo
% isso aqui é necessário porque
% \IfFileExists ignora o comando \graphicspath{...}
% https://tex.stackexchange.com/a/660433
% \input@path pode estar definido ou não; se estiver, não queremos redefini-lo!
\providecommand*\input@path{}
\newcommand*\ifch@if@image@exists[3]{%
  \begingroup
  \ifdefined\Ginput@path
    \edef\input@path{\input@path\Ginput@path}%
  \fi
  \IfFileExists{#1}{\endgroup #2}{\endgroup #3}%
}
\newcommand*\ifch@bad@logo[1]{%
  \PackageError{ifchunicamp}
  {o arquivo de logo "#1" não foi encontrado}
  {}% sem ajuda extra
}
% \alturalogounicamp negativa significa que será calculada na hora de colocar
% o logo na capa
\newdimen\alturalogounicamp \alturalogounicamp=\m@ne\p@\relax
\newcommand*\ifch@logo@file{logo.pdf}
\newcommand*\ifch@put@logo{%
  \ifch@if@image@exists{\ifch@logo@file}{%
    % https://tex.stackexchange.com/a/672078
    \AddToHookNext{shipout/background}{%
      % shipout/background This hook adds a picture environment into the background of the
      % page with the (0,0) coordinate in the top-left corner using a \unitlength of 1pt.
      % uma distância vertical negativa significa "pra baixo"
      \put(\spinemargin, \dimexpr -\uppermargin - \alturalogounicamp\relax){%
        \includegraphics[height=\alturalogounicamp]{\ifch@logo@file}%
      }%
    }%
  }
  {\ifch@bad@logo{\ifch@logo@file}}%
}


% -- processamento de chaves
\NewCommandCopy\ifch@put@vfinal\@firstofone
\ExplSyntaxOn
\keys_define:nn { ifchunicamp }{
  % 1) opção "logo"
  logo .code:n = {
    \ifch@if@image@exists{#1}
      { \gdef\ifch@logo@file{#1} }
      { \ifch@bad@logo{#1} }
  },
  logo .value_required:n = true,
  % 2) opção "alturadologo"
  alturadologo .dim_gset:N = \alturalogounicamp,
  alturadologo .value_required:n = true,
  % 3) opção "semlogo": omite o logo na capa
  semlogo .code:n = { \global\let\ifch@put@logo=\relax },
  semlogo .value_forbidden:n = true,
  % 4) opção "naofinal": omite o bloco "ESTE TRABALHO CORRESPONDE À VERSÃO FINAL" na folha de rosto
  % usar \@gobble faria o conteúdo ser totalmente omitido,
  % mas queremos que ele ocupe espaço sem aparecer
  naofinal .code:n = { \global\let\ifch@put@vfinal=\phantom },
  naofinal .value_forbidden:n = true,
}  % fim de \keys_define:nn
\ExplSyntaxOff
\ProcessKeyOptions[ifchunicamp]\relax


% -- carregamento de abntex2
% abnTeX2 carrega hyperref e bookmark, que dão o comando \pdfbookmark
% https://github.com/abntex/abntex2/blob/f0a4d3c8589f0f2e7c087880f0816debda036eb4/tex/latex/abntex2/abntex2.cls#L126
\PassOptionsToPackage{unicode}{hyperref}
% carregamos abntex2 agora, mas precisamos corrigir umas coisas relativas a título estrangeiro...
\newcommand\theforeigntitle{}
\PassOptionsToClass{%
  a4paper,    % ver Manual p. 29
  12pt,       % ver Manual p. 29
  oneside,    % impressão apenas em frente
  openright,  % capítulos começam em páginas ímpares
}{abntex2}
\LoadClass{abntex2}
\renewcommand\tituloestrangeiro[1]{\renewcommand\theforeigntitle{#1}}


% -- tamanhos
\setlrmarginsandblock{3cm}{2cm}{*}     % ver Manual p. 29
\setulmarginsandblock{3cm}{2cm}{*}
\checkandfixthelayout
\parindent=2cm\relax                   % tamanho da tabulação; ver Manual p. 29
\ABNTEXcitacaorecuo=4cm\relax          % recuo em citações longas; ver Manual p. 29


% -- cabeçalhos e rodapés
% o número de página deve estar no canto superior direito (Manual p. 29)
% abntex2 faz o seguinte:
% https://github.com/abntex/abntex2/blob/0cb2fe32e3ca5dbcbb08098497603777837f5098/tex/latex/abntex2/abntex2.cls#L640
% \makepagestyle{abntheadings}
% \makeevenhead{abntheadings}{\ABNTEXfontereduzida\thepage}{}{\ABNTEXfontereduzida\textit\leftmark}
% \makeoddhead{abntheadings}{\ABNTEXfontereduzida\textit\rightmark}{}{\ABNTEXfontereduzida\thepage}
% \makeheadrule{abntheadings}{\textwidth}{\normalrulethickness}
%
% \makepagestyle{abntchapfirst}
% \makeoddhead{abntchapfirst}{}{}{\ABNTEXfontereduzida\thepage}
%
% vamos fazer os 2 estilos iguais ao de começo de capítulo,
% e adicionar \ttfamily à impressão da página nesse estilo
\aliaspagestyle{abntheadings}{abntchapfirst}
\makeoddhead{abntchapfirst}{}{}{\ABNTEXfontereduzida\ttfamily\thepage}


% -- comandos internos diversos
\newcommand\ifch@smashed@parbox[1]{%
  % \smash não é \long (não tolera argumento contendo \par),
  % então essa macro é mais ou menos \smash só que \long
  % https://tex.stackexchange.com/a/424204
  \begingroup
  \sbox\@tempboxa{\parbox{\linewidth}{#1}}%
  \ht\@tempboxa=\z@
  \dp\@tempboxa=\z@
  \usebox\@tempboxa
  \endgroup
}


% -- macros configuráveis pelas opções do usuário
% -- preâmbulo
\RenewDocumentCommand\preambulo{ O{brazil} m }{%
  \renewcommand*\imprimirpreambulo{%
    \texorpdfstring{\selectlanguage{#1}#2}{#2}%
  }%
}

% -- preâmbulo em outra língua estrangeira (inglês ou espanhol)
\newcommand*\imprimirpreambuloestrangeiro{}
\NewDocumentCommand\preambuloestrangeiro{ O{brazil} m }{%
  \renewcommand*\imprimirpreambuloestrangeiro{%
    \texorpdfstring{\selectlanguage{#1}#2}{#2}%
  }%
}

% -- subtítulos
% https://github.com/abntex/abntex2/blob/f0a4d3c8589f0f2e7c087880f0816debda036eb4/tex/latex/abntex2/abntex2.cls#L697
% o subtítulo não pode conter \par porque \MakeUppercase não é \long!
\newcommand*\imprimirsubtitulo{}
\newcommand*\subtitulo[1]{\renewcommand*\imprimirsubtitulo{#1}}
\newcommand*\imprimirsubtituloestrangeiro{}
\newcommand*\subtituloestrangeiro[1]{\renewcommand*\imprimirsubtituloestrangeiro{#1}}
\newcommand\ifch@subtitle@line{%
  \abntex@ifnotempty{\imprimirsubtitulo}{%
    :\par\MakeUppercase{\imprimirsubtitulo}%
  }%
}


% -- versão final
\newcommand*\imprimirversaofinal{}
\newcommand*\textodeversaofinal[1]{\renewcommand*\imprimirversaofinal{#1}}


% -- configurações diversas
\renewcommand\imprimirlocal{Campinas}
\renewcommand\imprimirinstituicao{%
  % isso não é usado aqui. é usado em abnTeX2 só para fazer a folha de rosto,
  % mas nós temos nossa própria folha de rosto
  Universidade Estadual de Campinas%
}
% o Manual do IFCH chama a capa de "primeira folha"; cf. abntex2.pdf p. 13
\newcommand*\capaname{Primeira folha}
\addto\captionsbrazil{\renewcommand*\capaname{Primeira folha}}
\addto\captionsenglish{\renewcommand*\capaname{First page}}
% o Manual chama a folha de rosto de "página de rosto"
\addto\captionsbrazil{\renewcommand*\folhaderostoname{Página de rosto}}
% https://en.sguerra.com.br/o-que-e-ficha-catalografica
\newcommand*\fcatalograficaname{Ficha catalográfica}
\addto\captionsbrazil{\renewcommand*\fcatalograficaname{Ficha catalográfica}}
\addto\captionsenglish{\renewcommand*\fcatalograficaname{Catalog card}}
\AddToHook{env/fichacatalografica/begin}{%
  \pdfbookmark{\fcatalograficaname}{fichacatalografica}%
}
% "SUMÁRIO" em maiúsculas; Manual p. 28 e CCPG p. 19:
\newcommand*\sumario{%
  \begingroup
  \edef\oldcontentsname{\contentsname}%
  % coloca o sumário nas bookmarks do pdf; cf abntex2.pdf p. 13
  \def\contentsname{\pdfbookmark{\oldcontentsname}{toc}\MakeUppercase{\oldcontentsname}}%
  \tableofcontents*% o sumário não lista a si mesmo (nem partes pré-textuais)
  \endgroup
  \clearpage                                % https://tex.stackexchange.com/a/24993/90645
}
\AddToHook{begindocument}{%
  % se o usuário não carregou graphicx em seu preâmbulo e precisamos imprimir o logo,
  % carregue graphicx
  \@ifpackageloaded{graphicx}{}{%
    \ifx\relax\ifch@put@logo\else\RequirePackage{graphicx}\fi
  }%
  \hypersetup{%
    pdftitle={\@title},
    pdfauthor={\@author},
    % pdfkeywords={},
    pdfsubject={\imprimirpreambulo},
  }%
}



% == CAPA ==
\renewcommand\imprimircapa{%
\begin{capa}%
  \pdfbookmark{\capaname}{capa}% <- antes do \selectlanguage!
  \selectlanguage{brazil}%
  % NÃO USE \topskip=0pt; isso dá problemas com a paginação:
  % https://tex.stackexchange.com/q/550398
  \topskip=1sp\relax
  \parindent=\z@
  \ABNTEXchapterfont
  \centering
  %\nointerlineskip

% CAPA: LOGOTIPO
\begingroup
  \setbox\@tempboxa=\vbox{\halign{%
    \bfseries\hfill##\hfill\cr  % duplo # por estarmos dentro de uma definição de macro
    UNIVERSIDADE ESTADUAL DE CAMPINAS\cr
    INSTITUTO DE FILOSOFIA E CIÊNCIAS HUMANAS\cr
  }}%
  % a altura mínima do logotipo é 10mm
  % a altura máxima "em um formulário" é 6% do maior lado do papel
  % 0,06*297mm = 17,82mm
  % https://www.unicamp.br/logotipo
  \ifdim\alturalogounicamp<\z@ \global\alturalogounicamp=\dimexpr \ht\@tempboxa + \dp\@tempboxa \relax\fi
  \ifdim\alturalogounicamp<10mm\global\alturalogounicamp=10mm\fi
  \ifdim\alturalogounicamp>17.82mm\global\alturalogounicamp=17.82mm\fi
  \ifch@put@logo  % isso é \relax quando vigora a opção "semlogo"
% CAPA: INSTITUIÇÃO
% \MakeUppercase e \MakeTextUppercase não são \long
% (não toleram macros contendo \par),
% mas \uppercase funciona (com os \expandafter)
%\textbf{\expandafter\uppercase\expandafter{\imprimirinstituicao}}
  \usebox\@tempboxa
\endgroup

% CAPA: AUTOR
\vspace*{3\onelineskip}%
\MakeUppercase{\large\imprimirautor}

% CAPA: TÍTULO
% vplace é definido pela classe memoir (base de abnTeX2)
% "the optional argument specifies the ratio of the upper space to the lower space"
\begin{vplace}[1]
  \ifch@smashed@parbox{%
    \centering\LARGE
    \MakeUppercase{\bfseries\imprimirtitulo}\ifch@subtitle@line
    %
    \abntex@ifnotempty{\imprimirtituloestrangeiro}{%
        \par\vspace*{2\onelineskip}%
        % esse \let vigora só dentro do \parbox
        \let\imprimirsubtitulo=\imprimirsubtituloestrangeiro
        \MakeUppercase{\bfseries\imprimirtituloestrangeiro}\ifch@subtitle@line
    }%
  }
\end{vplace}

% CAPA: LOCAL E DATA
\large
\vfill
\MakeUppercase{\imprimirlocal}\\%
\imprimirdata
\end{capa}%
% abnTeX2 desconsidera a capa para a paginação,
% mas as normas do IFCH consideram
\stepcounter{page}%
}



% == FOLHA DE ROSTO ==
\renewcommand\folhaderostocontent{%
  \selectlanguage{brazil}%
  % NÃO USE \topskip=0pt; isso dá problemas com a paginação:
  % https://tex.stackexchange.com/q/550398
  \topskip=1sp\relax
  \parindent=\z@
  \centering

% FOLHA DE ROSTO: AUTOR
\MakeUppercase{\large\imprimirautor}

\begin{vplace}[1]
\ifch@smashed@parbox{%
  \centering
  % FOLHA DE ROSTO: TÍTULO
  \begingroup
  \ABNTEXchapterfont\Large\MakeUppercase{\imprimirtitulo}\ifch@subtitle@line
  \abntex@ifnotempty{\imprimirtituloestrangeiro}{%
    \par\vspace*{2\onelineskip}%
    % esse \let vigora só dentro do \parbox
    \let\imprimirsubtitulo=\imprimirsubtituloestrangeiro
    \MakeUppercase{\imprimirtituloestrangeiro}\ifch@subtitle@line
  }%
  \endgroup

% FOLHA DE ROSTO: PREÂMBULO
\abntex@ifnotempty{\imprimirpreambulo}{%
  \vspace*{.12\textheight}%
  \hspace*{\fill}%
  \parbox{.5\textwidth}{\SingleSpacing\imprimirpreambulo}%
}

% FOLHA DE ROSTO: PREÂMBULO ESTRANGEIRO
\abntex@ifnotempty{\imprimirpreambuloestrangeiro}{%
  \hspace*{\fill}%
  \parbox{.5\textwidth}{\SingleSpacing\imprimirpreambuloestrangeiro}%
}

\flushleft
% FOLHA DE ROSTO: ORIENTAÇÃO
\vspace*{2\onelineskip}%
\textit{\imprimirorientadorRotulo}\enspace\imprimirorientador
\abntex@ifnotempty{\imprimircoorientador}{%
  \newline\textit{\imprimircoorientadorRotulo}\enspace\imprimircoorientador
}

% FOLHA DE ROSTO: VERSÃO FINAL
\vspace*{2\onelineskip}%
\if\relax\imprimirversaofinal\relax  % true se o texto de versão final está vazio
  \@tempswatrue \else \@tempswafalse
\fi
\ifx\ifch@put@vfinal\@firstofone  % .: precisamos imprimir a frase de versão final...
    \if@tempswa                   % ...mas o texto de versão final está vazio!
      \PackageError{ifchunicamp}
      {Não há texto de versão final. Por favor,
        informe o texto de versão final com o comando
        \protect\textodeversaofinal}
      {}% sem ajuda extra
    \fi
\fi
\if@tempswa\else
  \ifch@put@vfinal{%
    \parbox{.5\textwidth}{\ABNTEXfontereduzida\MakeUppercase{\imprimirversaofinal}}%
  }%
\fi
}% fim de \ifch@smashed@parbox
\end{vplace}

% FOLHA DE ROSTO: LOCAL E DATA
\large
%\bfseries
\MakeUppercase{\imprimirlocal}\\%
\imprimirdata
}

% ---
% FIM DAS CUSTOMIZAÇÔES
% ---
\endinput

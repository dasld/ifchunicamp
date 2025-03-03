% essa é a versão do LaTeX que provê \ProcessKeyOptions:
\NeedsTeXFormat{LaTeX2e}[2022-06-01]
% segundo o documento "LATEX2e for class and package writers", a data do pacote
% deve ser a primeira (ou única) informação no argumento opcional de \ProvidesPackage
% e vir no formato YYYY-MM-DD
\ProvidesClass{ifchunicamp}[2025-01-26]


% -- comandos básicos pra esta classe
\input misc.code.tex


% -- processamento de chaves
\input chaves.code.tex


% -- carregar book.cls e desfazer algumas coisas dela
% as opções padrão da classe book.cls são:
% letterpaper, 10pt, twoside, onecolumn, final, openright
\overfullrule=\z@  % acho que já é 0pt, mas só pra garantir
                   % book.cls seta \overfullrule=5pt se a opção "draft" é usada
\LoadClass[a4paper, 12pt, oneside, openany]{book}
  \let\pagestyle=\@gobble
  \let\thispagestyle=\@gobble
  \let\pagenumbering=\@gobble
  \let\@oddhead=\@empty  % <-- isso é desfeito por \mainmatter
\renewcommand*\and{%
  \ClassWarning{ifchunicamp}{%
    A classe ifchunicamp desabilita o comando
    \protect\and.%
  }%
}
\begingroup
\@for\next:=title,author,date,thanks,maketitle\do{%
  \expandafter\xdef
  \csname\next\endcsname#1{%
    % \ClassWarning é #1#2
    \noexpand\ClassWarning{ifchunicamp}{%
      A classe ifchunicamp desabilita o comando
      \expandafter\string\csname\next\endcsname.
      Use os comandos em português providos pela classe.%
    }%
  }%
}
\endgroup


% -- pacotes
\RequirePackage[brazilian]{babel}
\AddToHook{begindocument}{%
  % a documentação do babel diz que
  % "In the preamble, no language has been selected"
  % então vamos adiar informação sobre línguas para o documento em si, após o preâmbulo
  \ClassInfo{ifchunicamp}{%
    Linguas carregadas pelo babel:
    \csname bbl@loaded\endcsname.
    Lingua principal do documento:
    \languagename.%
  }%
  % se o usuário não carregou graphicx em seu preâmbulo e precisamos imprimir o logo,
  % carregue graphicx
  \IfPackageLoadedTF{graphicx}{}{%
    \ifx\relax\ifch@put@logo
    \else\RequirePackage{graphicx}%
    \fi
  }%
}
\RequirePackage[
  % é necessário especificar papel A4 aqui porque, se o usuário usou (por exemplo):
  % \documentclass[letterpaper]{ifchunicamp}
  % a opção letterpaper é ignorada por book.cls, mas reconhecida pelo geometry!
  % esse a4paper aqui prevalece sobre o que o user solicitou
  a4paper,
  top=3cm,
  left=3cm,
  bottom=2cm,
  right=2cm,
]{geometry}
\RequirePackage[babel]{microtype}
% a documentação de footmisc explica que
% setspace deve vir antes de footmisc
\RequirePackage{setspace}
\RequirePackage[bottom, hang]{footmisc}
  \renewcommand\hangfootparskip{0pt}%=0.5\baselineskip
  \renewcommand\hangfootparindent{\the\footnotemargin}
\RequirePackage[unicode]{hyperref}


% -- formatação manual de algumas coisas
% essas coisas são configuradas pela opção [12pt] de book.cls,
% então temos que fazê-las após carregar a classe:
\parindent=2cm  % exigido pelo IFCH
% book.cls define \parskip=0pt plus 1pt
% book.cls faz \raggedbottom quando se usa a opção oneside, então não precisamos
% dar \raggedbottom de novo


% -- frontmatter, mainmatter, backmatter
\newif\if@frontmatter

\renewcommand\frontmatter{%
  \cleardoublepage
  \@mainmatterfalse
  \@frontmattertrue
  \singlespacing
}

\renewcommand\mainmatter{%
  \cleardoublepage
  \@mainmattertrue
  \@frontmatterfalse
  \renewcommand\@oddhead{%
    \hfill\footnotesize\ttfamily\thepage
  }%
  \onehalfspacing
}

\renewcommand\backmatter{%
  \if@openright
    \cleardoublepage
  \else
    \clearpage
  \fi
  \@mainmatterfalse
  \@frontmatterfalse
  \onehalfspacing
}


% -- capítulo sem estrela (\chapter):
\renewcommand*\@makechapterhead[1]{%
  \if@frontmatter
    \ClassError{ifchunicamp}{%
      Não use capítulos numerados
      (\protect\chapter)
      na parte pré-textual;
      use \protect\chapter*%
    }{}% sem info adicional
  \fi
  %\vspace*{50\p@ }%
  \begingroup
  \parindent=\z@ \raggedright \normalfont
  \interlinepenalty=\@M
  \Huge \sffamily%\bfseries?
    \thechapter\enspace#1\par\nobreak
  \vskip-\topmargin
  \endgroup
}


% -- capítulo com estrela (\chapter*):
% este contador é incrementado em todo comando \chapter, mesmo os com estrela
\newcount\ifch@chapters  \ifch@chapters=0
\AddToHook{cmd/chapter/before}{\global\advance\ifch@chapters by 1\relax}
\renewcommand*\@makeschapterhead[1]{%
  %\vspace*{50\p@ }%
  \if@frontmatter
    \phantomsection  % é do hyperref.sty
    % o segundo argumento de \currentpdfbookmark tem que ser único pra cada bookmark,
    % então usamos o número de \ifch@chapters
    \currentpdfbookmark{#1}{pretextual\the\ifch@chapters}%
  \else
    \addcontentsline{toc}{chapter}{#1}%
  \fi
  \begingroup
  \if@frontmatter \centering \else \raggedright \fi
  \interlinepenalty=\@M
  \normalfont \Huge \sffamily
    #1\par\nobreak
  \vskip-\topmargin
  \endgroup
}


% fazer todos os tipos de seção
% (\section, \subsection, etc)
% usarem \sffamily e tirar o negrito (\mdseries força não-negrito)
\NewCommandCopy\book@startsection\@startsection
\renewcommand\@startsection[6]{%
  \book@startsection{#1}{#2}{#3}{#4}{#5}{#6\sffamily\mdseries}%
}


% -- citação longa da ABNT com indentação de 4cm exigida pelo IFCH
\renewenvironment{quotation}{%
  \list{}{%
    \listparindent=0pt \itemindent=0pt
    \rightmargin=0pt \leftmargin=4cm
    \parsep=\z@ \@plus \p@
    % \singlespacing de setspace.sty termina com
    % \vskip\baselineskip,
    % o que deixa uma linha branca feia antes do bloco
    % de citação à direita.
    \setstretch{\setspace@singlespace}%
    \footnotesize
  }\item\relax
}{\endlist}


\frontmatter
\input capa.code.tex
\input sumario.code.tex



\endinput

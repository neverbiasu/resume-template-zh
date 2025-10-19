% ============================================================================
% resume.cls - Simple clean resume class (XeLaTeX)
% Author: neverbiasu
% Date: 2025-09-09
% ----------------------------------------------------------------------------
% Features:
% - Clean layout, A4, 11pt
% - Prioritized sections: Education > Work > Research/Projects (by template)
% - Clickable hyperlinks (hyperref)
% - Avatar support via \photo[<width>]{<path>}
% - Simple \entry macro for items
% - Requires XeLaTeX (CJK-ready); defaults to common Windows fonts
% ============================================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[2025/09/09 v1.0 Simple Resume Class]

% Base class
\LoadClass[11pt,a4paper]{article}

% Require XeLaTeX (for CJK & fontspec)
\RequirePackage{ifxetex}
\ifxetex\else
  \PackageError{resume}{This class requires XeLaTeX}{Please compile with XeLaTeX (xelatex).}
\fi

% Layout & essentials
\RequirePackage[margin=1.8cm]{geometry}
\RequirePackage{graphicx}
\RequirePackage{xeCJK}
\RequirePackage{fontspec}
\RequirePackage{hyperref}
\RequirePackage{enumitem}
\RequirePackage{xcolor}
\RequirePackage{titlesec}
\RequirePackage{tabularx}

% Fonts (adjust in README if unavailable)
% Western fonts
\setmainfont{Times New Roman}
\setsansfont{Arial}
\setmonofont{Menlo}  % macOS compatible monospace font
% CJK fonts with BoldFont support for macOS/cross-platform
\IfFontExistsTF{STSong}{%
  \setCJKmainfont[BoldFont=STHeiti]{STSong}
  \setCJKsansfont{STHeiti}
}{%
  \IfFontExistsTF{Songti SC}{%
    \setCJKmainfont[BoldFont=Heiti SC]{Songti SC}
    \setCJKsansfont{Heiti SC}
  }{%
    % Fallback to Windows fonts
    \setCJKmainfont[BoldFont=SimHei]{SimSun}
    \setCJKsansfont{Microsoft YaHei}
  }
}

% Hyperref setup
\hypersetup{
  colorlinks=true,
  linkcolor=black,
  urlcolor=blue,
  citecolor=black
}

% Page look & spacing
\pagestyle{empty}
\setlength{\parindent}{0pt}
\setlength{\parskip}{3pt}
\setlist[itemize]{noitemsep, topsep=2pt, left=0pt}

% Section style: make section titles bold (works for both English and CJK)
% For CJK bold to work, ensure CJK fonts have BoldFont specified
\titleformat{\section}{\large\bfseries}{\thesection}{0.5em}{}
\titleformat{name=\section,numberless}{\large\bfseries}{}{0pt}{}
\titlespacing*{\section}{0pt}{8pt}{4pt}

% Header (name + contact + links + optional photo)
\makeatletter
\newcommand{\name}[1]{\def\@name{#1}}
\newcommand{\contact}[1]{\def\@contact{#1}}
\newcommand{\links}[1]{\def\@links{#1}}
% \photo[<width>]{<path>}
\newcommand{\photo}[2][3cm]{\def\@photosize{#1}\def\@photo{#2}}

% Hook for printing photo: default does nothing. The main document may redefine
% \PrintProfilePhoto after checking file existence to actually includegraphics
\newcommand{\PrintProfilePhoto}{}

\newcommand{\resumetitle}{%
  {\normalsize \@links\par}
  % No horizontal rule or extra vertical space here; BasicSection handles spacing.
}
\makeatother

% Entry macro: \entry{Title}{Org}{Location}{Dates}{\item ... \item ...}
\newcommand{\entry}[5]{%
  \textbf{#1} \hfill {\small #4}\par
  \textbf{#2}, #3\par
  \ifx&#5&%
    % If #5 is empty, don't create itemize
  \else
    \begin{itemize}[leftmargin=*]
      #5
    \end{itemize}
  \fi
  \vspace{2pt}
}

% Basic info display toggle: users can enable detailed basic info block in main.tex
% by calling \ShowBasicInfotrue in their content file (e.g., content/basic.tex).
\newif\ifShowBasicInfo
\ShowBasicInfofalse

\providecommand{\EducationSection}{\section*{Education}}
\providecommand{\ExperienceSection}{\section*{Experience}}
\providecommand{\SkillsSection}{\section*{Skills}}
\providecommand{\ProjectSection}{\section*{Projects}}
\providecommand{\PublicationSection}{\section*{Publications}}
\providecommand{\AwardSection}{\section*{Awards}}
\providecommand{\ContactInfo}{\section*{Contact}}

% Backward/alternative names used by content/*.tex
\providecommand{\WorkSection}{\section*{Work}}
\providecommand{\ResearchSection}{\section*{Research}}
\providecommand{\HonorsSection}{\section*{Honors}}
\providecommand{\PracticeSection}{\section*{Practice}}
\providecommand{\SelfSection}{\section*{Self}}
\providecommand{\ObjectiveSection}{\section*{Objective}}
\providecommand{\OtherSection}{\section*{Other}}

% End of class

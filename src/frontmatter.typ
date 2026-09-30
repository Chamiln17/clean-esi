// src/frontmatter.typ - ESI Algiers thesis frontmatter
// Following ESI standards for cover page, abstracts, etc.

#import "colors.typ": *

// ══════════════════════════════════════════════════════════════════════════════
// ESI COVER PAGE - The "ESI Grid" Layout
// ══════════════════════════════════════════════════════════════════════════════

#let esi_cover_page(
  title: "Thesis Title",
  authors: (), // Array of author names
  supervisor: none,
  co_supervisors: (), // Array of co-supervisor names
  report_type: "Final Year Thesis",
  institution: "National Higher School of Computer Science",
  option: "Computer Systems (SIQ)",
  degree_type: "State Engineer Degree in Computer Science",
  host_organization: "",
  promotion: "2024/2025",
  defense_date: "XX/XX/2026", // Defense date (format: DD/MM/YYYY)
  jury: (), // Array of (name, affiliation, role)
  logo_image: none, // Pass the actual image, not a path
) = {
  set page(
    numbering: none,
    margin: (top: 1.5cm, bottom: 1.5cm, left: 2.54cm, right: 2.54cm),
    header: none,
    footer: none,
  )
  set text(size: 10.5pt)

  // ─────────────────────────────────────────────────────────────────────────────
  // BLOCK A: State Header (Top, Centered)
  // ─────────────────────────────────────────────────────────────────────────────
  align(center)[
    #text(size: 12pt, weight: "regular")[
      République Algérienne Démocratique et Populaire
    ]
    #v(0.2em)
    #text(size: 12pt, dir: rtl, font: ("Amiri", "Scheherazade New", "Arial"))[
      الجمهورية الجزائرية الديمقراطية الشعبية
    ]
    #v(0.3em)
    #text(size: 11pt)[
      Ministère de l'Enseignement Supérieur et de la Recherche Scientifique
    ]
    #v(0.2em)
    #text(size: 11pt, dir: rtl, font: ("Amiri", "Scheherazade New", "Arial"))[
      وزارة التعليم العالي و البحث العلمي
    ]
  ]

  v(0.35em)
  line(length: 100%, stroke: 0.3mm + black)
  v(0.35em)

  // ─────────────────────────────────────────────────────────────────────────────
  // BLOCK B: Institutional Header (Logo left, Text right)
  // ─────────────────────────────────────────────────────────────────────────────
  grid(
    columns: (5cm, 1fr),
    column-gutter: 0.8em,
    align(center + horizon)[
      #if logo_image != none {
        logo_image
      }
    ],
    align(right + horizon)[
      #text(size: 12pt, weight: "bold")[
        #institution
      ]
      #v(0.2em)
      #text(size: 10pt, style: "italic")[
        ex. INI (Institut National de formation en Informatique)
      ]
    ],
  )

  v(1.1em)

  // ─────────────────────────────────────────────────────────────────────────────
  // BLOCK C: Degree Information (Centered)
  // ─────────────────────────────────────────────────────────────────────────────
  align(center)[
    #text(size: 16pt, weight: "bold")[
      #report_type
    ]
    #v(0.35em)
    #text(size: 12pt)[
      For obtaining the #degree_type

    ]
    #v(0.25em)
    #text(size: 12pt, weight: "bold")[
      Option: #option
    ]
  ]

  v(1.1em)

  // ─────────────────────────────────────────────────────────────────────────────
  // BLOCK D: Thesis Title (Centered & Highlighted)
  // ─────────────────────────────────────────────────────────────────────────────
  line(length: 100%, stroke: 0.5pt + black)
  v(0.55em)
  align(center)[
/*     #text(size: 12pt, weight: "bold")[Theme:]
    #v(0.25em) */
    #text(size: 18pt, weight: "bold")[
      #title
    ]
  ]
  v(0.55em)
  line(length: 100%, stroke: 0.5pt + black)

  v(0.8em)

  // ─────────────────────────────────────────────────────────────────────────────
  // BLOCK E: Attribution (Authors left, Supervisors right)
  // ─────────────────────────────────────────────────────────────────────────────
  grid(
    columns: (1fr, 1fr),
    column-gutter: 2em,
    // Left: Authors
    align(center)[
      #text(weight: "bold", style: "italic")[
        #if authors.len() == 1 { [Author:] } else { [Authors:] }
      ]
      #v(0.2em)
      #for author in authors {
        text(size: 11pt)[#author]
        linebreak()
      }
    ],
    // Right: Supervisors
    align(center)[
      #text(weight: "bold", style: "italic")[Supervised by:]
      #v(0.2em)
      #if supervisor != none {
        text(size: 11pt)[#supervisor]
        linebreak()
      }
      #for co_supervisor in co_supervisors {
        text(size: 11pt)[#co_supervisor]
        linebreak()
      }
    ],
  )

  v(0.7em)

  // ─────────────────────────────────────────────────────────────────────────────
  // BLOCK F: The Jury - Grid with proper alignment (matches Block E above)
  // Column 1 (left): Name + Affiliation
  // Column 2 (right): Role
  // ─────────────────────────────────────────────────────────────────────────────
  if jury.len() > 0 {
    align(center)[
      #text(weight: "bold", size: 11pt)[Defended on #defense_date, before the jury composed of:]
      #v(0.45em)
      #grid(
        columns: (1fr, 1fr),
        column-gutter: 2em, // Match Block E above
        row-gutter: 0.6em,
        ..jury
          .map(member => (
            // Column 1: Name + Affiliation (left-aligned)
            align(center)[
              #text(size: 11pt)[#member.at(0) (#member.at(1))]
            ],
            // Column 2: Role (right-aligned, bold)
            align(right)[
              #align(center)[#text(size: 11pt, weight: "bold")[#member.at(2)]]
            ],
          ))
          .flatten()
      )
    ]
  }

  v(0.65em)

  align(center)[
    #text(weight: "bold")[Host organization:]
    #h(0.35em)
    #if host_organization != "" {
      text(size: 11pt)[#host_organization]
    } else {
      text(size: 11pt)[-----------------]
    }
  ]

  v(1fr)

  // ─────────────────────────────────────────────────────────────────────────────
  // BLOCK G: Footer
  // ─────────────────────────────────────────────────────────────────────────────
  align(center)[
    #text(size: 13pt, weight: "bold")[
      Academic year: #promotion
    ]
  ]

  pagebreak(weak: true)
}

// ══════════════════════════════════════════════════════════════════════════════
// SEPARATE ABSTRACT PAGES (ESI Standard - One per page)
// ══════════════════════════════════════════════════════════════════════════════

#let abstract_page_en(
  abstract_content: none,
  keywords: (),
) = {
  heading(level: 1, numbering: none)[Abstract]

  v(0.5em)

  if abstract_content != none {
    set par(leading: 0.65em, spacing: 0.65em) // Single spacing for abstracts
    text(size: 11pt)[#abstract_content]
  }

  v(1.5em)

  if keywords.len() > 0 {
    text(weight: "bold", size: 10pt)[Keywords: ]
    text(weight: "bold", style: "italic", size: 10pt)[#keywords.join(", ")]
  }

  pagebreak()
}

#let abstract_page_fr(
  abstract_content: none,
  keywords: (),
) = {
  heading(level: 1, numbering: none)[Résumé]

  v(0.5em)

  if abstract_content != none {
    set par(leading: 0.65em, spacing: 0.65em)
    text(size: 11pt)[#abstract_content]
  }

  v(1.5em)

  if keywords.len() > 0 {
    text(weight: "bold", size: 10pt)[Mots-clés : ]
    text(weight: "bold", style: "italic", size: 10pt)[#keywords.join(", ")]
  }

  pagebreak()
}

#let abstract_page_ar(
  abstract_content: none,
  keywords: (),
) = {
  set text(dir: rtl, font: ("Amiri", "Scheherazade New", "Arial"))

  heading(level: 1, numbering: none)[ملخص]

  v(0.5em)

  if abstract_content != none {
    set par(leading: 0.65em, spacing: 0.65em)
    text(size: 11pt)[#abstract_content]
  }

  v(1.5em)

  if keywords.len() > 0 {
    text(weight: "bold", size: 10pt)[كلمات مفتاحية: ]
    text(weight: "bold", style: "italic", size: 10pt)[#keywords.join("، ")]
  }

  pagebreak()
}

// ══════════════════════════════════════════════════════════════════════════════
// DEDICATION PAGE
// ══════════════════════════════════════════════════════════════════════════════

#let dedication_page(content) = {
  heading(level: 1, numbering: none)[Dedication]

  v(3em)
  align(center)[
    #text(style: "italic", size: 12pt)[#content]
  ]

  pagebreak()
}

// ══════════════════════════════════════════════════════════════════════════════
// ARABIC DEDICATION PAGE (RTL)
// ══════════════════════════════════════════════════════════════════════════════

#let arabic_dedication_page(
  verse_content,   // The Quranic verse block (content)
  body_content,    // The main dedication paragraphs (content)
) = {
  set text(dir: rtl, lang: "ar", font: ("Amiri", "Scheherazade New", "Arial"), size: 12pt)
  set par(leading: 0.85em, spacing: 1.1em, justify: true)

  // Title
  heading(level: 1, numbering: none)[إهداء]

  v(2em)

  // Quranic verse — centered, slightly larger, with decorative separators
  align(center)[
    #line(length: 40%, stroke: 0.4pt + luma(140))
    #v(0.8em)
    #text(size: 13pt, weight: "regular")[#verse_content]
    #v(0.8em)
    #line(length: 40%, stroke: 0.4pt + luma(140))
  ]

  v(2em)

  // Body paragraphs
  body_content

  pagebreak()
}

// ══════════════════════════════════════════════════════════════════════════════
// ACKNOWLEDGMENTS PAGE
// ══════════════════════════════════════════════════════════════════════════════

#let acknowledgments_page(content) = {
  heading(level: 1, numbering: none)[Acknowledgments]

  v(1em)
  content

  pagebreak()
}

// ══════════════════════════════════════════════════════════════════════════════
// TABLE OF CONTENTS
// ══════════════════════════════════════════════════════════════════════════════

#let table_of_contents() = {
  show heading.where(level: 1): it => {
    set par(first-line-indent: 0pt)
    v(65pt)
    text(size: 24pt, weight: "bold")[#it.body]
    v(11pt)
  }

  [
    #heading(level: 1, numbering: none)[Contents] <toc:contents>
  ]
  // Level 1 = Parts (and intro/conclusion/appendices); 2 = chapters; 3 = sections;
  // 4 = subsections. Chapters stay bold so they keep their prominence under Parts.
  show outline.entry: it => {
    let indent = if it.level == 1 { 0pt } else if it.level == 2 { 1.85em } else if it.level == 3 { 3.6em } else { 5.1em }
    let gap = if it.level == 1 { 1.7em } else if it.level == 2 { 0.66em } else { 0.70em }
    let entry_size = if it.level == 1 { 11pt } else if it.level == 2 { 10pt } else if it.level == 3 { 9.5pt } else { 9pt }
    let entry_weight = if it.level <= 2 { "bold" } else { "regular" }

    context {
      let loc = it.element.location()
      let toc_start_page = query(<toc:contents>).first().location().page()
      // Frontmatter entries show Roman numerals, main-content entries Arabic.
      let page_text = numbering(
        if loc.page-numbering() == none { "1" } else { loc.page-numbering() },
        ..counter(page).at(loc),
      )
      let heading_no = if it.element.numbering == none {
        none
      } else {
        let nums = counter(heading).at(loc)
        numbering(it.element.numbering, ..nums)
      }

      let skip_entry = loc.page() < toc_start_page or (it.level > 1 and heading_no == none)

      if not skip_entry {
        block(above: gap)[
          #h(indent)
          #text(size: entry_size, weight: entry_weight)[
            #if heading_no != none {
              heading_no
              h(if it.level == 1 { 0.45em } else { 0.55em })
            }
            #it.element.body
            #if it.level == 1 {
              h(1fr)
            } else {
              box(width: 1fr)[#it.fill]
            }
            #page_text
          ]
        ]
      }
    }
  }
  set par(first-line-indent: 0pt, leading: 0.2em, spacing: 0pt)
  v(29pt)
  outline(title: none, indent: auto, depth: 4)
  pagebreak()
}

// ══════════════════════════════════════════════════════════════════════════════
// LIST OF FIGURES
// ══════════════════════════════════════════════════════════════════════════════

#let list_of_figures() = {
  heading(level: 1, numbering: none)[List of Figures]
  show outline.entry: set block(above: 0.45em)
  show outline.entry: set text(size: 10pt)
  outline(
    title: none,
    target: figure.where(kind: image),
  )
  pagebreak()
}

// ══════════════════════════════════════════════════════════════════════════════
// LIST OF TABLES
// ══════════════════════════════════════════════════════════════════════════════

#let list_of_tables() = {
  heading(level: 1, numbering: none)[List of Tables]
  show outline.entry: set block(above: 0.45em)
  show outline.entry: set text(size: 10pt)
  outline(
    title: none,
    target: figure.where(kind: table),
  )
  pagebreak()
}

// ══════════════════════════════════════════════════════════════════════════════
// LIST OF ABBREVIATIONS
// ══════════════════════════════════════════════════════════════════════════════

#let abbreviations_page(items) = {
  heading(level: 1, numbering: none)[List of Abbreviations]

  v(1em)

  table(
    columns: (auto, 1fr),
    stroke: none,
    inset: (x: 0.5em, y: 0.4em),
    align: (left, left),
    ..items
      .map(item => (
        text(weight: "bold")[#item.at(0)],
        [#item.at(1)],
      ))
      .flatten()
  )

  pagebreak()
}

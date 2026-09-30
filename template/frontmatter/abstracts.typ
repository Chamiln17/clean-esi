#import "@preview/esi-pfe:0.1.0": abstract_page_ar, abstract_page_en, abstract_page_fr

// ESI requires one abstract per page: English, French, and Arabic.
#abstract_page_en(
  abstract_content: [Summarise the problem, the approach, and the main results in 200–300 words.],
  keywords: ("Keyword one", "Keyword two", "Keyword three"),
)

#abstract_page_fr(
  abstract_content: [Résumez le problème, l'approche et les principaux résultats.],
  keywords: ("Mot-clé un", "Mot-clé deux", "Mot-clé trois"),
)

#abstract_page_ar(
  abstract_content: [لخّص المشكلة والمنهجية وأهم النتائج.],
  keywords: ("كلمة أولى", "كلمة ثانية", "كلمة ثالثة"),
)

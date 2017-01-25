Sanitize::Rails.configure(
  elements:   %w[ del, dd, h3, address, big, sub, tt, a, ul, h4, cite, dfn, h5, small, kbd, code,
b, ins, img, h6, sup, pre, strong, blockquote, acronym, dt, br, p, div, samp,
li, ol, var, em, h1, i, abbr, h2, span, hr ],
  attributes: {
    :all  => ['style']
  },
)
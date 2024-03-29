import { defineConfig } from 'vitepress'

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "Acanthis",
  description: "Validation library",
  lastUpdated: true,
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    nav: [
      { text: 'Home', link: '/' },
    ],

    sidebar: [
      {
        text: 'Introduction',
        link: '/introduction',
      },
      {
        text: 'Operations',
        items: [
          { text: 'Checks', link: '/operations/checks' },
          { text: 'Transformations', link: '/operations/transformations' },
        ]
      },
      {
        text: 'Types',
        items: [
          { text: 'Boolean', link: '/types/boolean' },
          { text: 'String', link: '/types/string' },
          { text: 'Number', link: '/types/number' },
          { text: 'Date', link: '/types/date' },
          { text: 'List', link: '/types/list' },
          { text: 'Map', link: '/types/map' },
          { text: 'Nullable', link: '/types/nullable' },
          { text: 'Union', link: '/types/union' },
        ]
      }
    ],

    socialLinks: [
      { icon: 'github', link: 'https://github.com/francescovallone/acanthis' }
    ]
  }
})

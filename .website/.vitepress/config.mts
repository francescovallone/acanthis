import { defineConfig } from 'vitepress'

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "Acanthis",
  description: "Validation library",
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    nav: [
      { text: 'Home', link: '/' },
    ],

    sidebar: [
      {
        text: 'Introduction',
        link: '/',
      },
    ],

    socialLinks: [
      { icon: 'github', link: 'https://github.com/francescovallone/acanthis' }
    ]
  }
})

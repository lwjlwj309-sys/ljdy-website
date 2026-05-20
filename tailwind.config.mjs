/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}'],
  theme: {
    extend: {
      colors: {
        gold: {
          50: '#fdf8ee',
          100: '#f9edcc',
          200: '#f2d999',
          300: '#e8c566',
          400: '#d4af37',
          500: '#c8a45c',
          600: '#b8860b',
          700: '#9a7209',
          800: '#7a5a07',
          900: '#5c4305',
        },
        dark: {
          50: '#f8f9fa',
          100: '#e9ecef',
          200: '#ced4da',
          300: '#adb5bd',
          400: '#6c757d',
          500: '#495057',
          600: '#343a40',
          700: '#212529',
          800: '#1a1a2e',
          900: '#0f0f1a',
        },
      },
      fontFamily: {
        sans: ['Noto Sans SC', 'Inter', 'sans-serif'],
      },
    },
  },
  plugins: [],
};

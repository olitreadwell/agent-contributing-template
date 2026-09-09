// Minimal flat config: this repo has no app TS/JS, only the template's
// .mjs scripts. Lint those with base rules; everything else is ignored.
const nodeGlobals = {
  process: 'readonly',
  console: 'readonly',
  Buffer: 'readonly',
  URL: 'readonly',
  setTimeout: 'readonly',
  clearTimeout: 'readonly',
  setInterval: 'readonly',
  clearInterval: 'readonly',
  globalThis: 'readonly',
  structuredClone: 'readonly',
};

export default [
  {
    ignores: ['node_modules/**', '.next/**', 'docs/**', '**/*.json'],
  },
  {
    files: ['**/*.mjs'],
    languageOptions: {
      ecmaVersion: 2022,
      sourceType: 'module',
      globals: nodeGlobals,
    },
    rules: {
      'no-undef': 'error',
      'no-unused-vars': 'warn',
    },
  },
];

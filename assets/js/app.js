// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//
// If you have dependencies that try to import CSS, esbuild will generate a separate `app.css` file.
// To load it, simply add a second `<link>` to your `root.html.heex` file.

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import {hooks as colocatedHooks} from "phoenix-colocated/codie"
import topbar from "../vendor/topbar"

const elixirKeywords = [
  "after",
  "alias",
  "and",
  "case",
  "catch",
  "cond",
  "def",
  "defdelegate",
  "defexception",
  "defguard",
  "defguardp",
  "defimpl",
  "defmacro",
  "defmacrop",
  "defmodule",
  "defp",
  "defprotocol",
  "defstruct",
  "do",
  "else",
  "end",
  "false",
  "fn",
  "for",
  "if",
  "import",
  "in",
  "is_nil",
  "is_atom",
  "is_binary",
  "is_boolean",
  "is_float",
  "is_function",
  "is_integer",
  "is_list",
  "is_map",
  "is_number",
  "is_tuple",
  "nil",
  "not",
  "or",
  "quote",
  "raise",
  "receive",
  "require",
  "rescue",
  "reraise",
  "super",
  "throw",
  "true",
  "try",
  "unless",
  "unquote",
  "unquote_splicing",
  "use",
  "when",
  "with",
]

const loadMonaco = (() => {
  let promise

  const defineElixirLanguage = (monaco) => {
    if (window.__codieMonacoConfigured) return

    window.__codieMonacoConfigured = true

    monaco.languages.register({id: "elixir"})
    monaco.languages.setLanguageConfiguration("elixir", {
      comments: {
        lineComment: "#",
      },
      brackets: [
        ["{", "}"],
        ["[", "]"],
        ["(", ")"],
      ],
      autoClosingPairs: [
        {open: "{", close: "}"},
        {open: "[", close: "]"},
        {open: "(", close: ")"},
        {open: "\"", close: "\""},
      ],
      surroundingPairs: [
        {open: "{", close: "}"},
        {open: "[", close: "]"},
        {open: "(", close: ")"},
        {open: "\"", close: "\""},
      ],
    })

    monaco.languages.setMonarchTokensProvider("elixir", {
      defaultToken: "",
      keywords: elixirKeywords,
      tokenizer: {
        root: [
          [/[A-Z][\w]*/, "type.identifier"],
          [/[a-z_?!][\w?!]*/, {
            cases: {
              "@keywords": "keyword",
              "@default": "identifier",
            },
          }],
          [/@[a-z_][\w?!]*/, "annotation"],
          [/:\w+/, "string.escape"],
          [/~[A-Z]?[a-z]?/, "regexp"],
          [/\b0x[\da-fA-F_]+\b/, "number.hex"],
          [/\b\d+(_\d+)*(\.\d+(_\d+)*)?\b/, "number"],
          [/"/, {token: "string.quote", bracket: "@open", next: "@string"}],
          [/#.*$/, "comment"],
          [/[{}()[\]]/, "@brackets"],
          [/[<>]=|[=!]=|===|!==|&&|\|\||\|>|<-|->|=>|\\|\+\+|--|<>|\+|-|\*|\/|=/, "operators"],
          [/[,:.]/, "delimiter"],
          [/\s+/, "white"],
        ],
        string: [
          [/[^\\"]+/, "string"],
          [/\\./, "string.escape"],
          [/"/, {token: "string.quote", bracket: "@close", next: "@pop"}],
        ],
      },
    })

    monaco.editor.defineTheme("codie-coffee", {
      base: "vs-dark",
      inherit: true,
      rules: [
        {token: "keyword", foreground: "DF8F3F", fontStyle: "bold"},
        {token: "string", foreground: "E9C46A"},
        {token: "number", foreground: "85B8FF"},
        {token: "comment", foreground: "8A786B", fontStyle: "italic"},
        {token: "type.identifier", foreground: "6CD1B0"},
        {token: "annotation", foreground: "F4A261"},
      ],
      colors: {
        "editor.background": "#120F0E",
        "editor.foreground": "#F8ECE3",
        "editorLineNumber.foreground": "#6F6158",
        "editorLineNumber.activeForeground": "#EFD6C2",
        "editorCursor.foreground": "#DF8F3F",
        "editor.selectionBackground": "#47352A",
        "editor.inactiveSelectionBackground": "#30241D",
        "editorIndentGuide.background1": "#2A211E",
        "editorIndentGuide.activeBackground1": "#534036",
      },
    })
  }

  return () => {
    if (window.monaco?.editor) {
      defineElixirLanguage(window.monaco)
      return Promise.resolve(window.monaco)
    }

    if (promise) return promise

    promise = new Promise((resolve, reject) => {
      const waitForLoader = () => {
        if (!window.require) {
          window.setTimeout(waitForLoader, 30)
          return
        }

        window.require.config({paths: {vs: "/vendor/monaco/vs"}})
        window.require(["vs/editor/editor.main"], () => {
          defineElixirLanguage(window.monaco)
          resolve(window.monaco)
        }, reject)
      }

      waitForLoader()
    })

    return promise
  }
})()

const loadMonacoVim = (() => {
  let promise

  return () => {
    if (window.MonacoVim?.initVimMode) {
      return Promise.resolve(window.MonacoVim)
    }

    if (promise) return promise

    promise = fetch("/vendor/monaco-vim/monaco-vim.umd.js")
      .then((response) => {
        if (!response.ok) {
          throw new Error(`Failed to load monaco-vim: ${response.status}`)
        }

        return response.text()
      })
      .then((source) => {
        const executor = new Function(
          "window",
          "globalThis",
          "self",
          "define",
          "module",
          "exports",
          source,
        )

        executor(window, window, window, undefined, undefined, undefined)

        if (!window.MonacoVim?.initVimMode) {
          throw new Error("monaco-vim did not expose initVimMode")
        }

        return window.MonacoVim
      })

    return promise
  }
})()

const Hooks = {
  CodeEditor: {
    mounted() {
      this.textarea = this.el.querySelector("[data-role='editor-input']")
      this.surface = this.el.querySelector("[data-role='editor-surface']")
      this.vimStatus = this.el.querySelector("[data-role='vim-status']")
      this.form = this.textarea?.form
      this.saveTimer = null
      this.editor = null
      this.vimMode = null
      this.isApplyingServerValue = false
      this.editorVersion = this.readEditorVersion()
      this.lastSavedValue = this.readServerValue()
      this.focusEditor = () => {
        if (!this.editor) return

        this.editor.focus()

        // Monaco sometimes mounts before its hidden textarea is focus-ready.
        window.requestAnimationFrame(() => this.editor?.focus())
      }
      this.handleSubmit = () => this.syncHiddenInput()

      loadMonaco().then((monaco) => {
        this.monaco = monaco
        this.editor = monaco.editor.create(this.surface, {
          value: this.lastSavedValue,
          language: "elixir",
          theme: "codie-coffee",
          automaticLayout: true,
          minimap: {enabled: false},
          fontFamily: "Iosevka, IBM Plex Mono, SFMono-Regular, monospace",
          fontSize: 15,
          lineHeight: 24,
          lineNumbersMinChars: 3,
          padding: {top: 16, bottom: 16},
          roundedSelection: false,
          scrollBeyondLastLine: false,
          tabSize: 2,
          insertSpaces: true,
          wordWrap: "on",
          guides: {indentation: true},
        })

        this.editor.updateOptions({
          cursorBlinking: "solid",
          cursorSmoothCaretAnimation: "on",
        })

        loadMonacoVim()
          .then((monacoVim) => {
            this.vimMode = monacoVim.initVimMode(this.editor, this.vimStatus)
            this.focusEditor()
          })
          .catch((error) => {
            console.error("Failed to initialize vim mode", error)
            if (this.vimStatus) {
              this.vimStatus.textContent = "Vim mode failed to load"
            }
          })

        this.editor.onDidChangeModelContent(() => {
          if (this.isApplyingServerValue) return

          this.syncHiddenInput()
          this.scheduleDraftSave()
        })

        this.editor.addCommand(monaco.KeyMod.CtrlCmd | monaco.KeyCode.Enter, () => {
          this.syncHiddenInput()
          this.pushDraftSave()
          this.textarea.form?.requestSubmit()
        })

        this.editor.onDidFocusEditorText(() => {
          this.el.classList.add("is-focused")
        })

        this.editor.onDidBlurEditorText(() => {
          this.el.classList.remove("is-focused")
        })

        this.surface.addEventListener("mousedown", this.focusEditor)
        this.surface.addEventListener("click", this.focusEditor)
        this.form?.addEventListener("submit", this.handleSubmit)
        this.syncHiddenInput()
        this.focusEditor()
      })
    },
    updated() {
      if (!this.editor || !this.textarea) {
        this.editorVersion = this.readEditorVersion()
        this.lastSavedValue = this.readServerValue()
        return
      }

      const nextVersion = this.readEditorVersion()

      if (nextVersion !== this.editorVersion) {
        this.editorVersion = nextVersion
        this.applyServerValue(this.readServerValue())
      } else {
        this.syncHiddenInput()
      }
    },
    destroyed() {
      window.clearTimeout(this.saveTimer)

      if (this.surface) {
        this.surface.removeEventListener("mousedown", this.focusEditor)
        this.surface.removeEventListener("click", this.focusEditor)
      }

      if (this.form) {
        this.form.removeEventListener("submit", this.handleSubmit)
      }

      if (this.vimMode) {
        this.vimMode.dispose()
      }

      if (this.editor) {
        this.editor.dispose()
      }
    },
    readEditorVersion() {
      const parsed = Number.parseInt(this.el.dataset.editorVersion || "0", 10)
      return Number.isNaN(parsed) ? 0 : parsed
    },
    readServerValue() {
      return this.el.dataset.editorValue ?? this.textarea?.value ?? ""
    },
    applyServerValue(value) {
      if (!this.editor) return

      window.clearTimeout(this.saveTimer)

      const currentValue = this.editor.getValue()

      if (value === currentValue) {
        this.lastSavedValue = value
        this.syncHiddenInput()
        return
      }

      this.isApplyingServerValue = true
      this.editor.setValue(value)
      this.editor.setPosition({lineNumber: 1, column: 1})
      this.editor.revealPositionInCenter({lineNumber: 1, column: 1})
      this.isApplyingServerValue = false
      this.lastSavedValue = value
      this.syncHiddenInput()
    },
    scheduleDraftSave() {
      window.clearTimeout(this.saveTimer)
      this.saveTimer = window.setTimeout(() => this.pushDraftSave(), 700)
    },
    pushDraftSave() {
      if (!this.editor || !this.textarea) return

      const value = this.editor.getValue()

      if (this.lastSavedValue === value) return

      this.lastSavedValue = value
      this.pushEvent("save_draft", {code: value})
    },
    syncHiddenInput() {
      if (!this.editor || !this.textarea) return

      const value = this.editor.getValue()

      this.textarea.value = value
    },
  },
}

const csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
const liveSocket = new LiveSocket("/live", Socket, {
  longPollFallbackMs: 2500,
  params: {_csrf_token: csrfToken},
  hooks: {...colocatedHooks, ...Hooks},
})

// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#df8f3f"}, shadowColor: "rgba(23, 19, 18, 0.35)"})
window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

// The lines below enable quality of life phoenix_live_reload
// development features:
//
//     1. stream server logs to the browser console
//     2. click on elements to jump to their definitions in your code editor
//
if (process.env.NODE_ENV === "development") {
  window.addEventListener("phx:live_reload:attached", ({detail: reloader}) => {
    // Enable server log streaming to client.
    // Disable with reloader.disableServerLogs()
    reloader.enableServerLogs()

    // Open configured PLUG_EDITOR at file:line of the clicked element's HEEx component
    //
    //   * click with "c" key pressed to open at caller location
    //   * click with "d" key pressed to open at function component definition location
    let keyDown
    window.addEventListener("keydown", e => keyDown = e.key)
    window.addEventListener("keyup", _e => keyDown = null)
    window.addEventListener("click", e => {
      if(keyDown === "c"){
        e.preventDefault()
        e.stopImmediatePropagation()
        reloader.openEditorAtCaller(e.target)
      } else if(keyDown === "d"){
        e.preventDefault()
        e.stopImmediatePropagation()
        reloader.openEditorAtDef(e.target)
      }
    }, true)

    window.liveReloader = reloader
  })
}

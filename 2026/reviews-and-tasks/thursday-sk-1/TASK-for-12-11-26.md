# Notes app – task for 12 Nov

- **App:** `NotesApp` (the agent's code)
- **From:** 05/11/26
- **Date:** 05/11/26

For every answer, give the **file and line**.

## Already filled in

1. **State:** What did the agent decide about state – `@State`, `@Observable`, local or global state?
   - **Global state:** none, no `@Observable`
   - **Local state:** `@State private var notes: [Note] = []` and `@State private var path: [Note.ID] = []`
   - Where: [ContentView.swift, lines 10–11](https://github.com/filip-vabrousek-utb/AP9PT/blob/main/2026/W08-Notes/thursday-sk-1/NotesApp/ContentView.swift#L10-L11)

## Beginning of the next lab (12 Nov)

2. **Detail:** Is it a copy, or a `@Binding`? Check by clicking: change a note in the detail – do you see the change in the list?
   - Detail:
   - Where:
3. **Navigation:** How does the app know which note to open? What happens to `path` when you add a note?
   - Navigation:
   - Where:

**Due:** start of the lab on 12 Nov – you get 5–10 minutes there, then we go through the answers together.

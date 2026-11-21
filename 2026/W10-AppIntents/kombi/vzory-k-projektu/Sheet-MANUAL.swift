import SwiftUI

// Formulář jako list (sheet), který vyjede zespodu, a jak ho zavřít tlačítkem uvnitř.
// Sheet řídí Bool ve stavu: true = otevřený, false = zavřený.
// dismiss() se bere z prostředí view, které je UVNITŘ sheetu – ne z view, které sheet otevírá.

struct SheetDemoView: View {
    @State private var ukazForm = false
    @State private var jmeno = ""

    var body: some View {
        VStack(spacing: 20) {
            Text(jmeno.isEmpty ? "Zatím bez jména" : "Ahoj, \(jmeno)!")
                .font(.title)
            Button("Otevřít formulář") {
                ukazForm = true
            }
            .buttonStyle(.borderedProminent)
        }
        .sheet(isPresented: $ukazForm) {
            FormView { noveJmeno in jmeno = noveJmeno }   // formulář vrátí jméno přes closure
        }
    }
}

struct FormView: View {
    @Environment(\.dismiss) private var dismiss   // z prostředí view uvnitř sheetu
    let onSave: (String) -> Void                  // co udělat s výsledkem – rozhodne rodič
    @State private var koncept = ""

    var body: some View {
        NavigationStack {
            Form {
                TextField("Jméno", text: $koncept)
            }
            .navigationTitle("Formulář")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Zrušit") { dismiss() }      // se závorkami – jinak se nic nestane
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Uložit") {
                        onSave(koncept)
                        dismiss()
                    }
                    .disabled(koncept.isEmpty)
                }
            }
        }
    }
}

#Preview { SheetDemoView() }

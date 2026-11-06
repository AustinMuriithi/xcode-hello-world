// xcode: set sdk=iOS

import SwiftUI

struct ContentView: View {
    @State private var name = ""
    @State private var greeting = "Hello, World!"
    @State private var showNameError = false
    @FocusState private var isNameFocused: Bool

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    VStack(alignment: .leading, spacing: 12) {
                        Image(systemName: "hand.wave.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.blue)
                            .accessibilityHidden(true)

                        Text("A little hello, just for you.")
                            .font(.largeTitle.bold())

                        Text("Enter your name and make this greeting your own.")
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Your name")
                            .font(.headline)

                        TextField("Enter your name", text: $name)
                            .textFieldStyle(.roundedBorder)
                            .textContentType(.givenName)
                            .textInputAutocapitalization(.words)
                            .submitLabel(.go)
                            .accessibilityLabel("Your name")
                            .accessibilityIdentifier("nameField")
                            .focused($isNameFocused)
                            .onSubmit(sayHello)
                            .onChange(of: name) { _ in
                                showNameError = false
                            }

                        if showNameError {
                            Label("Please enter your name.", systemImage: "exclamationmark.circle")
                                .font(.callout)
                                .foregroundStyle(.red)
                                .accessibilityIdentifier("nameError")
                        }

                        Button(action: sayHello) {
                            Text("Say hello")
                                .font(.headline)
                                .frame(maxWidth: .infinity, minHeight: 44)
                        }
                        .buttonStyle(.borderedProminent)
                        .accessibilityIdentifier("sayHelloButton")
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("YOUR GREETING")
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(.secondary)
                        Text(greeting)
                            .font(.title2.bold())
                            .accessibilityIdentifier("helloWorldLabel")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(24)
                    .background(Color(uiColor: .secondarySystemGroupedBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .frame(maxWidth: 500)
                .padding(24)
                .frame(maxWidth: .infinity)
            }
            .background(Color(uiColor: .systemGroupedBackground))
            .scrollDismissesKeyboard(.interactively)
            .navigationTitle("Hello")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    // Share validation between button and keyboard submission.
    static func greeting(for name: String) -> String? {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else { return nil }
        return "Hello, \(trimmedName)!"
    }

    private func sayHello() {
        guard let message = Self.greeting(for: name) else {
            showNameError = true
            isNameFocused = true
            return
        }
        greeting = message
        showNameError = false
        isNameFocused = false
    }
}

#Preview {
    ContentView()
}

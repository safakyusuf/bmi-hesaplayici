//
//  ContentView.swift
//  BMIHesaplayici
//
//  Created by Yusuf Şafak on 18.04.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var bmi: Double = 0
    @State private var kilo: Double? = nil
    @State private var boy: Double? = nil
    @State private var alert: Bool = false
    @State private var islem: String = ""
    @State private var saglik1 = 0.0
    @State private var saglik2 = 0.0
    @FocusState private var isFocused: Bool
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Boy cm") {
                    TextField("Boyunuzu Giriniz", value: $boy, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                }
                Section("Kilo") {
                    TextField("Kilonuzu girin", value: $kilo, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                    
                }
                
                
                Button("Hesapla") {
                    guard let kilo, let boy, kilo > 0, boy > 0 else {
                        alert = true
                        sifirla()
                        return
                    }
                    isFocused = false
                    bmi = kilo / pow(boy / 100, 2)
                    islem = kilolu(bmi)
                    saglik1 = pow(boy / 100, 2) * 18.5
                    saglik2 = pow(boy / 100, 2) * 24.9
                }
                .frame(maxWidth: .infinity)
                .padding(13)
                .background(.blue)
                .foregroundStyle(.white)
                .font(.headline)
                .clipShape(.buttonBorder)
//            }
//            .listRowInsets(EdgeInsets())
                
                
                Section("Sonuç") {
                    Text("Boy kilo indeksiniz: \(bmi, specifier: "%.1f") \(islem)")
                        .foregroundStyle(renkFonk(bmi))
                        .font(.headline)
                    
                }
                
                Section("İdeal Kilo Aralıkları") {
                    Text("\(saglik1, specifier: "%.1f") ile \(saglik2, specifier: "%.1f")")
                }
                
            }
            
            .navigationTitle("BMI Hesaplayıcı")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Sıfırla") {
                        sifirla()
                        bmi = 0
                        islem = ""
                    }
                }
            }
            .alert("Uyarı", isPresented: $alert) {
                Button("Tamam") { }
            } message: {
                Text("Lütfen doğru değerler giriniz")
            }
        }
    }
    func sifirla() {
        kilo = nil
        boy = nil
        saglik1 = 0
        saglik2 = 0
    }
    
    func kilolu(_ sayi: Double) -> String {
        if sayi > 40 {
            return "3. Derece Obezite"
        } else if sayi >= 35 {
            return "2. Derece Obezite"
        } else if sayi >= 30 {
            return "1. Derece Obezite"
        } else if sayi >= 25 {
            return "Fazla Kilolu"
        } else if sayi >= 18.5 {
            return "Normal"
        } else if sayi > 0 {
            return "Zayıf"
        } else {
            return ""
        }
    }
    
    
    func renkFonk(_ sayi: Double) -> Color {
        if sayi >= 30 {
            return .red          // Obezite
        } else if sayi >= 25 {
            return .orange       // Fazla Kilolu
        } else if sayi >= 18.5 {
            return .green        // Normal
        } else if sayi > 0 {
            return .orange       // Zayıf
        } else {
            return .black
        }
    }
}
#Preview {
    ContentView()
}

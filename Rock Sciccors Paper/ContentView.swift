import SwiftUI
struct TitleStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.black)
    }
}
extension View{
    func titleStyle() -> some View {
        self.modifier(TitleStyle())
    }
}
struct ChoiceStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .foregroundColor(.white)
    }
}
extension View{
    func choiceStyle() -> some View{
        self.modifier(ChoiceStyle())
    }
}
struct SmallTextStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .foregroundColor(.black)
    }
}
extension View{
    func smallTextStyle() -> some View{
        self.modifier(SmallTextStyle())
    }
}
struct ButtonStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .frame(width: 100, height: 75)
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 25, height: 25)))
            .overlay(RoundedRectangle(cornerSize: CGSize(width: 25, height: 25))
                                    .stroke(Color.black, lineWidth: 1.5))
            .shadow(color: .black, radius: 1, x: 0.0, y: 0.0)
    }
}
extension View{
    func buttonStyle() -> some View{
        self.modifier(ButtonStyle())
    }
}

struct ContentView: View {
    @State private var possibleMoves = ["rock", "paper", "scissors"]
    @State private var currentChoice = Int.random(in: 0..<3)
    @State private var userToWin = Bool.random()
    @State private var userScore = 0
    @State private var userCorrectMessage = ""
    @State private var userCorrectSubMessage = ""
    @State private var userCorrect = false
    @State private var userCorrectDisplay = false
    let gradient = Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple])
    var correctChoice: Int {
        if userToWin {
            switch currentChoice {
            case 0: return 1
            case 1: return 2
            case 2: return 0
            default: return 0
            }
        } else {
            switch currentChoice {
            case 0: return 2
            case 1: return 0
            case 2: return 1
            default: return 0
            }
        }
    }
    var body: some View{
        ZStack{
            AngularGradient(gradient: gradient, center: .center)
                            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack(spacing:50){
                VStack(spacing:25){
                    Text("The computer choses...")
                        .smallTextStyle()
                    Text(possibleMoves[currentChoice])
                        .fontWeight(.black)
                        .titleStyle()
                    if userToWin {
                        Text("Beat the computer.")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .titleStyle()
                    } else {
                        Text("Let the computer win.")
                            .fontWeight(.bold)
                            .titleStyle()
                    }
                    
                }
                HStack(spacing: 30){
                    ForEach(0..<3){choiceIndex in
                        Button(action: {
                            self.choiceTapped(choiceIndex)
                        }, label: {
                            Image("\(possibleMoves[choiceIndex])")
                                .padding(-50.0)
                                
                        })
                    }
                }
                VStack(spacing: 25){
                    Text("Your score is \(userScore)")
                        .smallTextStyle()
                    Text("Get to 10 to win!")
                        .smallTextStyle()
                }.alert(isPresented: $userCorrectDisplay){
                    Alert(title: Text(userCorrectMessage), message: Text(userCorrectSubMessage), dismissButton: .default(Text("Let's Play!")){
                        self.gameReset()
                    })
                }
            }
        }
    }
    func choiceTapped (_ number: Int){
        if number == correctChoice {
            if userScore == 9 {
                userCorrectMessage = "You Win!"
                userCorrectSubMessage = """
                Your final score is \(userScore + 1)
                PLay Again?
                """
                userScore = 0
            } else {
                userCorrect = true
                userCorrectMessage = "Correct"
                userScore += 1
                userCorrectSubMessage = """
                You're so smart
                Your score is \(userScore)
                """
            }
        } else {
            userCorrect = false
            userCorrectMessage = "Incorrect"
            userScore -= 1
            userCorrectSubMessage = """
            The correct answer was \(possibleMoves[correctChoice])
            Your score is \(userScore)
            """
        }
        userCorrectDisplay = true
    }
    func gameReset(){
        let previousChosenMove = currentChoice
        while previousChosenMove == currentChoice {
            currentChoice = Int.random(in: 0...2)
        }
        userToWin = Bool.random()
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
.previewInterfaceOrientation(.portrait)
    }
}

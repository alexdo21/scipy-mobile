# SciPy Suite
 
Mobile (SciPy Mobile) and web (SciPy Web) applications giving users direct access to SciPy's scientific computing functionalities.
 
[Click here to watch a demo of SciPy Mobile](https://www.youtube.com/watch?v=DSa7pLDoxJo)  
[Click here to watch a demo of SciPy Web](https://www.youtube.com/watch?v=SOUVwJVtz-s)
 
The tech stack of SciPy Suite is:
- Swift and UIKit with third-person LaTeX renderer libraries [iosMath](https://github.com/kostub/iosMath) and [MathEditor](https://github.com/kostub/MathEditor) for the mobile front end.
- React with LaTeX renderer [better-react-mathjax](https://github.com/fast-reflexes/better-react-mathjax) for the web front end.
- Flask with scipy and sympy packages.
 
Relevant repositories:
- [SciPy API](https://github.com/alexdo21/scipy-api)
- [SciPy Mobile](https://github.com/alexdo21/scipy-mobile)
- [SciPy Web](https://github.com/alexdo21/scipy-web)
 
# Running Locally
 
1. Clone all three repositories.
2. Open SciPy API in PyCharm, activate the virtual environment via env activate and use the SciPy API Local run configuration to start the application (both can be done in the terminal since the run configuration is just a shell script).
3. Open ScipyMobile.xcworkspace in Xcode, run a pod install command, and build and run the application for an iPhone 13 Pro target simulator/device.
4. In SciPy Web run npm install to download all required packages and npm start to start the application.
 
# Background
 
As the name indicates, SciPy Suite (est. 2022) is a collection of projects backed by one API. Currently there are two main interfaces- a mobile app and a web app. SciPy Suite was built to utilize the scientific computing powers of Python and integrate it with modern mobile and web technologies.
 
Something that inspired me to create this project was that I always used tools like Jupyter notebooks in my college classes to compute complex equations and models. But I wished there was a more accessible way to interact with Python's scientific packages. I was inspired by apps/websites such as Mathway, WolframAlpha, Derivative calculator and Integral calculator, and I wanted to create my own version to use as a personal tool and to help me learn more advanced math.
 
Both front-end applications were designed using Figma.
 
# Technical Details
 
## SciPy API
 
SciPy API is meant to be as functional as possible, meaning that whatever requests it receives it'll simply compute the problem and return it in a client-app readable format format. SciPy API holds no state. As a Flask app, SciPy API takes advantage of blueprints to organize its endpoints. Each blueprint corresponds to a specific category namely: Calculus and Linear Algebra, with endpoints for each desired computation. The endpoints by category are:
 
- **Calculus**
 - Symbolic Derivative
 - Solve Derivative
 - Symbolic (indefinite) Integral
 - Solve (definite) Integral
 
- **Linear Algebra**
 - Matrix Determinant
 - Matrix Inverse
 
Each endpoint in turn calls a service function that computes the given problem and returns in a client-app readable format. The request input and output are meant to be as simple and RESTful as possible. The input is always a request object containing the expression/problem and other fields required to compute the solution. The output is always a response object with one field containing the solution to the specified problem.
 
## SciPy Mobile
 
SciPy Mobile makes use of a lot of object-oriented programming and class hierarchies. Unlike web technologies such as React, Swift and UIKit make it very easy to code imperatively like I would with Java.
 
SciPy Mobile uses a ContainerViewController as the root view controller of the entire app. ContainerViewController uses a custom SideMenuViewController for navigation and a ContentViewController to display the content. ContainerViewController is composed via a utility function that injects the application's view controllers into a ContainerViewController at startup. This way, it is easy to extend the app's functionality declaratively in the future. The SideMenuViewController and ContentViewController's interaction play a pivotal role in the user experience.
 
The way the class hierarchy is setup is meant to parallel the aforementioned categories and their respective endpoints in SciPy API. Thus, there are two main controllers that extend ContentViewController: CalculusController and LinearAlgebraController. All service calls to SciPy API are made from a shared instance of ScipyService.
 
### CalculusController
 
CalculusController holds three important objects:
 
- a ProblemContainer to display the problem to solve.
- a ControlPanelModalViewController to edit the current expression and type of problem to solve.
- a SolutionModalViewController to display the computed result.
 
CalculusController in turn is extended by two classes that are actually instantiated at startup and are injected while composing the ContainerViewController. They are:
 
- DerivativeController, which handles picking either solving whether or not to solve the derivative symbolically and making the call to SciPy API for the derivative result.
- IntegralController, which handles picking either solving an indefinite or definite integral and making the call to SciPy API for the integral result.
 
### LinearAlgebraController
 
LinearAlgebraController holds three custom components:
 
- a matrix editor, which is custom made from a 2D array of UIStackViews of UITextFields allowing users to enter in matrix cell values.
- matrix row/col editors, which are UIPickerViews that allow the user to change the size of the matrix editor (1x1 up to 5x5).
- a SolutionModalViewController to display the computed result.
 
LinearAlgebraController, similarly, is extended by two classes that are instantiated and injected into ContainerViewController at startup. They are:
 
- DeterminantController, which handles calling the SciPy API for the determinant result.
- InverseController, which handles calling the SciPy API for the inverse matrix result.
 
LinearAlgebraController also contains several methods for matrix validation such as requiring both the number of rows and columns of the matrix editor to be equal in order to compute the determinant and inverse.
 
### LaTeX
 
SciPy Mobile makes a lot of use of iosMath and MathEditor in order to render math expressions nicely. Specifically, iosMath is used to render the expressions for derivative and integrals in the problem container and solution modal, and MathEditor is used in the CalculusController's control panel to edit expressions on the fly.
 
### UI & UX
 
SciPy mobile uses an intricate combination of NSLayoutConstraints, custom extensions, custom views and the class hierarchy to implement the design from Figma. The SideMenuViewController is collapsible and there are a lot of UIGestureRecognizerDelegates to improve the user experience.
 
## SciPy Web
 
SciPy Web was built after SciPy Mobile so a lot of the infrastructure and architecture was adapted from SciPy Mobile in order to work with programming in React. Using react-router, SciPy Web is composed declaratively at the top-level with the route convention of {category}/{feature}, making it aligned with SciPy API, where each route points to the specified page namely- Derivative, Integral, Determinant and Inverse. SciPy Web also uses a Sidebar component to handle navigation.
 
Because SciPy Web is built from functional components, it uses shared components instead of a class hierarchy. Each component is declared in its respective pages, using passed down props to determine what page is rendering it, and callbacks to update the parent state. Thus, the parent page components act as view controllers in this architecture.
 
### Shared Components
 
- **ExpressionLabel**, analogous to a ProblemContainer, takes in specifiedPage (derivative or integral) and specifiedType (symbolic or solve) props to determine what content to render for its parent page. And it takes in a callback to update the problem expression (derivative or integral problem) the user wants to solve.
 
- **ControlPanel**, analogous to ControlPanelModalViewController, also takes in specifiedPage (derivative or integral) and specifiedType (symbolic or solve) props, and additionally takes in callbacks to update the with respect to (wrt), at value, from and to states.
 
- **SolveButton** takes care of calling SciPy service and updating the problem result (derivative, integral, determinant or inverse) after it has successfully returned from the back end by passing in yet another callback.
 
- **Solution** deals with rendering the problem and result after result has been set.
 
- **MatrixEditor**, analogous to the matrix editor component in LinearAlgebraController, takes the rows and cols state from the parent page to determine the size of the matrix (1x1 up to 5x5) and callbacks to resize them. It also takes in a callback to reset the result state anytime it's updated.
 
### Pages
 
Each page is listed below with the shared components it contains:
 
- **Derivative Page**
 - ExpressionLabel
 - ControlPanel
 - SolveButton
 - Solution
 
- **Integral Page**
 - ExpressionLabel
 - ControlPanel
 - SolveButton
 - Solution
 
- **Determinant Page**
 - MatrixEditor
 - SolveButton
 - Solution
 
- **Inverse Page**
 - MatrixEditor
 - SolveButton
 - Solution
 
### Latex
 
The ExpressionLabel and Solution components make use of MathJax from better-react-mathjax to render LaTeX strings. Note that the expression editor in ControlPanel doesn't render LaTeX, but it automatically updates the ExpressionLabel as the user types. This is all made possible by wrapping the entirety of SciPy Web in a MathJaxContext.
 
### UI & UX
 
Apart from any third-person functional components (i.e MathJax), SciPy Web uses vanilla CSS to implement the entire design from Figma. Most notably, learning CSS flexbox helped me a lot with development time. SciPy Web is also responsive. It has a collapsible Sidebar component and is designed to be used by devices ranging from small tablets to large monitors (consider using SciPy Mobile for mobile devices!).
 
# Room For Improvement
 
- Differentiate SciPy Suite by adding very advanced computations not found in other similar apps.
- Add Signal Processing features such as discrete and continuous Fourier transforms.
- Add graphing / modeling capabilities.
- Add unit / integration tests.
 

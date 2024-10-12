This application includes the MVVM architecture and clean code. I applied the new technologies I learned while adhering to these principles. 
Technologies used:

- Background thread
- Weak self
- Combine
- Publishers and Subscribers
- FileManager
- NSCache

API calls are made using Combine, and the received data is stored locally to prevent re-downloading it each time. Local data is optional within the application, and by changing the manager used, both NSCache and FileManager implementations can be observed.

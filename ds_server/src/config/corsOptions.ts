// export const allowedOrigins: string[] = ['http://localhost:8080']

// export const corsOptions = {
//   origin: (
//     origin: string,
//     callback: (arg0: Error | null, arg1: boolean) => void
//   ) => {
//     if (allowedOrigins.indexOf(origin) !== -1 || !origin) {
//       callback(null, true)
//     } else {
//       callback(new Error('Not allowed by CORS!!!!!!!!'), true)
//     }
//   },
//   credentials: true,
//   optionsSuccessStatus: 200,
// }

// just allow all for now
export const corsOptions = {
  origin: true,
  credentials: true,
  optionsSuccessStatus: 200,
}

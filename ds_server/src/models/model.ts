import mongoose, { Schema } from 'mongoose'
interface IMessage {
  message: string
}
const messageSchema: Schema = new Schema(
  {
    message: { type: String, required: true },
  },
  { timestamps: true }
)
export const Message = mongoose.model<IMessage>('Message', messageSchema)

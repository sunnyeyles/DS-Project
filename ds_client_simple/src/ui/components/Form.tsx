import { useForm, SubmitHandler } from 'react-hook-form'
import { messagesApi } from '../../api/apiSlice'
import '../index.css'
type Inputs = {
  message: string
  messageRequired: string
}

export const PostForm = () => {
  const [addNewMessage] = messagesApi.useAddNewMessageMutation()
  const {
    register,
    handleSubmit,
    watch,
    formState: { errors },
  } = useForm<Inputs>()
  const onSubmit: SubmitHandler<Inputs> = (data) => {
    console.log(data)
    addNewMessage({ message: data.message })
  }

  console.log(watch('message'))

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <div>
        <input
          placeholder="Post a Message"
          className="input"
          {...register('message', { required: true })}
        />

        <input className="button" type="submit" />
      </div>
      {errors.messageRequired && <span>This field is required</span>}
    </form>
  )
}

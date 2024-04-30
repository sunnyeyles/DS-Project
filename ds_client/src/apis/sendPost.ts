import axios from 'axios'
interface IPostProps {
  postBody: string
}
export const sendPost = async ({ postBody }: IPostProps) => {
  try {
    await axios.post('/api/post-message', {
      message: postBody,
    })
  } catch (error) {
    console.log(error)
  }
}

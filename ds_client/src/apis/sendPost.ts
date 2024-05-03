import axios from 'axios'
interface IPostProps {
  postBody: string
}
export const sendPost = async ({ postBody }: IPostProps) => {
  try {
    await axios.post('http://localhost:3001/api/post-message', {
      message: postBody,
    })
  } catch (error) {
    console.log(error)
  }
}

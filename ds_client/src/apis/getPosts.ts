import axios from 'axios'
interface IPostProps {
  postBody: string
}
export const getPosts = async () => {
  try {
    const response = await axios.get('/api/get-messages')
    console.log(response)
  } catch (error) {
    console.error(error)
  }
}

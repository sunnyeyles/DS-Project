export const getAllMessages = async () => {
  try {
    const response = await fetch('http://localhost:3001/api/get-messages')
    if (!response.ok) {
      throw new Error('Network response was not ok')
    }
    const data = await response.json()
    console.log(data)
  } catch (error) {
    console.error('Error:', error)
  }
}

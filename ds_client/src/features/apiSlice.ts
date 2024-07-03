import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react'
type MessageType = {
  id?: string
  message: string
  createdAt?: string
}
export const messagesApi = createApi({
  reducerPath: 'messagesApi',
  tagTypes: ['Messages'],
  baseQuery: fetchBaseQuery({
    baseUrl: 'http://backend/api/',
  }),
  endpoints: (builder) => ({
    getAllMessages: builder.query<MessageType[], void>({
      query: () => 'get-messages',
      providesTags: ['Messages'],
    }),
    addNewMessage: builder.mutation<MessageType, MessageType>({
      query: (message) => ({
        url: 'post-message',
        method: 'POST',
        body: message,
      }),
      invalidatesTags: ['Messages'],
    }),
  }),
})

export const { useGetAllMessagesQuery, useAddNewMessageMutation } = messagesApi

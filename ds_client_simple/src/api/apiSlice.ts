import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react'
import { MessageTypes } from './types'

export const messagesApi = createApi({
  reducerPath: 'messagesApi',
  tagTypes: ['Messages'],
  baseQuery: fetchBaseQuery({
    baseUrl: 'http://backend/api/',
  }),
  endpoints: (builder) => ({
    getAllMessages: builder.query<MessageTypes[], void>({
      query: () => 'get-messages',
      providesTags: ['Messages'],
    }),
    addNewMessage: builder.mutation<MessageTypes[], MessageTypes>({
      query: (message) => ({
        url: 'post-message',
        method: 'POST',
        body: message,
      }),
      invalidatesTags: ['Messages'],
    }),
  }),
})

// export default messagesApi;
export const { useGetAllMessagesQuery, useAddNewMessageMutation } = messagesApi

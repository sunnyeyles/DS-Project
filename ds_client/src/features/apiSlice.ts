import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react'
import { IMessageTypes } from '@/types/mainTypes'
export const messagesApi = createApi({
  reducerPath: 'messagesApi',
  tagTypes: ['Messages'],
  baseQuery: fetchBaseQuery({
    baseUrl: 'http://backend/api/',
  }),
  endpoints: (builder) => ({
    getAllMessages: builder.query<IMessageTypes[], void>({
      query: () => 'get-messages',
      providesTags: ['Messages'],
    }),
    addNewMessage: builder.mutation<IMessageTypes[], IMessageTypes>({
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

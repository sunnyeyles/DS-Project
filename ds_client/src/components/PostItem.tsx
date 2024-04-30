import { CardBody, CardItem, CardContainer } from './ui/3d-card'

export const PostItem = () => {
  return (
    <CardContainer className="flex flex-col gap-4 bg-slate-800 border w-80 h-80 rounded-md p-10">
      <h3 className="text-slate-300 text-md italic">Anonymous-</h3>
      <p className="text-slate-600">
        Lorem ipsum dolor sit amet consectetur adipisicing elit. Deserunt, iure.
        Nisi debitis explicabo ex molestiae, veritatis dolore voluptatem quasi
        eligendi qui veniam, facere officia, minima suscipit. Ea ipsa incidunt
        explicabo, iusto ratione voluptas perferendis vel numquam optio
      </p>
    </CardContainer>
  )
}

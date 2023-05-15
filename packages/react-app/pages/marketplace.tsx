import { Fragment, useState } from 'react'
import DropdownSelect from '@/components/DropdownSelect'
import Card from '@/components/Card'

const categories = [
  { name: 'Politics' },
  { name: 'Sports' },
  { name: 'World Events' },
  { name: 'Cinema' },
]

const sortBy = [
  { name: 'Newest' },
  { name: 'Oldest' },
  { name: 'Most Popular' },
]

export default function Marketplace() {
  const [selected, setSelected] = useState(categories[0])
  const [selectedSort, setSelectedSort] = useState(sortBy[0])

  return (
    <div className="flex flex-col items-center w-full flex-1 sm:py-4 text-center">

      <div className="sm:my-4 grid gap-x-6 gap-y-2 sm:grid-cols-9 items-center">
        <div className="sm:col-span-3 flex items-center">
          <p className="block sm:text-xl tracking-wider font-light leading-6 text-ash mr-4">
            Category
          </p>
          <DropdownSelect items={categories} selected={selected} setSelected={setSelected} />
        </div>
        <div className="sm:col-span-3 flex items-center">
          <p className="block sm:text-xl tracking-wider font-light leading-6 text-ash mr-4">
            Sort by
          </p>
          <DropdownSelect items={sortBy} selected={selectedSort} setSelected={setSelectedSort} />
        </div>
        <div className="sm:col-span-3 flex items-center">
          <input
            id="completed"
            name="completed"
            type="checkbox"
            className="h-6 sm:h-12 w-6 sm:w-12 rounded-lg border-ash text-prosperity focus:ring-prosperity"
          />
          <div className='sm:w-48'>
            <p className="font-light sm:text-xl text-ash ml-4">Show Completed.</p>
          </div>
        </div>

        
      </div>


      <main className="flex flex-col items-center w-full flex-1 p-4 sm:px-4 xl:px-6 sm:py-6 text-center mt-4 bg-slate rounded-lg">
        <div className="w-full grid md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-3 gap-6 mt-4">
          <Card />
          <Card />
          <Card />
          <Card />
          <Card />
        </div>

      </main>

    </div>
  )
}

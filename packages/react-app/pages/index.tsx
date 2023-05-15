import { Fragment, useState } from 'react'
import Card from '@/components/Card'
import { Jumbotron } from '@/components/Jumbotron'
import BottomSection from '@/components/BottomSection'

export default function Home() {

  return (
    <div className="flex flex-col items-center w-full flex-1 sm:py-4 text-center">

      <Jumbotron />

      <main className="flex flex-col items-center w-full flex-1 p-4 sm:px-4 xl:px-6 sm:py-6 text-center my-4 bg-slate rounded-lg">

        <div className="flex flex-row items-center w-full justify-between">
          <p className="block sm:text-xl tracking-wider font-light leading-6 text-charcoal mr-4">
            Current Events
          </p>
        </div>

        <div className="w-full grid md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-3 gap-6 mt-4">
          <Card />
          <Card />
          <Card />
        </div>

        <a href="/marketplace" className="text-charcoal border rounded-md border-charcoal px-4 py-2 hover:bg-charcoal hover:text-slate mt-4">
          View all
        </a>

      </main>

      <BottomSection />

    </div>
  )
}

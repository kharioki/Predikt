import Image from "next/image";

export default function Card() {
  return (
    <div className="w-full max-w-sm bg-white rounded-lg">
      <div className="flex flex-row items-center justify-between py-4 px-4">
        <div className="flex flex-row items-center justify-center">
          <img className="w-12 h-12 rounded-full" src="https://res.cloudinary.com/khariokitony/image/upload/v1653176236/origamis/pikachu-3d.jpg" alt="Eventimage" width={48} height={48} />
          <h5 className="ml-2 text-md text-ash text-left">Who will win the basketball playoffs.</h5>
        </div>
        <div className="flex flex-row items-center px-4">
          <span className="relative flex h-3 w-3 ml-2">
            <span className="animate-ping relative inline-flex rounded-full h-3 w-3 bg-success"></span>
          </span>
        </div>
      </div>

      <div className="flex flex-row items-center justify-between py-6 px-4">
        <div className="flex flex-col items-center">
          <h5 className="text-md text-ash">Volume</h5>
          <p className="text-ash text-lg font-mono">$21,000</p>
        </div>

        <div className="flex flex-row items-center justify-between space-x-4 bg-slate py-4 px-2 rounded-lg">
          <button className="flex flex-col items-center px-2">
            <h5 className="mb-1 text-md text-ash">Lakers</h5>
            <p className="text-sky font-bold font-mono">x1.2</p>
          </button>
          <div className="flex flex-col items-center px-2">
            <h5 className="mb-1 text-md text-ash">Warriors</h5>
            <p className="text-sky font-bold font-mono">x6.20</p>
          </div>
        </div>
        
        <div className="flex flex-col items-center ml-3">
          <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor" className="w-8 h-8 text-gray-300">
            <path strokeLinecap="round" strokeLinejoin="round" d="M11.48 3.499a.562.562 0 011.04 0l2.125 5.111a.563.563 0 00.475.345l5.518.442c.499.04.701.663.321.988l-4.204 3.602a.563.563 0 00-.182.557l1.285 5.385a.562.562 0 01-.84.61l-4.725-2.885a.563.563 0 00-.586 0L6.982 20.54a.562.562 0 01-.84-.61l1.285-5.386a.562.562 0 00-.182-.557l-4.204-3.602a.563.563 0 01.321-.988l5.518-.442a.563.563 0 00.475-.345L11.48 3.5z" />
          </svg>
        </div>
      </div>

      <div className="flex flex-col justify-between py-2 px-4 items-end">
          <a href="/123" className="text-ash border rounded-md border-sand px-2 py-1 hover:bg-ash hover:text-slate mt-4">
            View event
          </a>
      </div>

    </div>

  )
}
import { useRouter } from "next/router";

export default function Event() {
  const router = useRouter();
  return (
    <div className="bg-slate flex flex-col items-center w-full flex-1 sm:py-8 px-8 text-center">
      Event: {router.query.event}
    </div>
  )
}
import * as THREE from 'three'

const planeGeometry = new THREE.PlaneGeometry(1, 1, 16, 15)
const sphereGeometry = new THREE.SphereGeometry(10, 32, 16)

export default function () {
  return {
    planeGeometry,
    sphereGeometry
  }
}

from math import cos
import math

import rclpy
from turtle_controller.circle_turtle import CircleTurtle


class WeirdTurner(CircleTurtle):
    def __init__(self, vel_theta_max: float = 1.0, omega: float = 3.141, vel_phi: float = 1.047, timer_period: float = 0.01):
        CircleTurtle.__init__(self, omega=omega, timer_period=timer_period)
        
        self.vel_theta_max = vel_theta_max
        self.vel_phi = vel_phi
    
    def _publish_velocity(self) -> None:
        t = self.get_clock().now().nanoseconds * 10e-9
        self.vel_theta = self.vel_theta_max * cos(self.omega * t + self.vel_phi)

        return CircleTurtle._publish_velocity(self)
    
    
def main():
    rclpy.init()
    
    weird_turner = WeirdTurner(vel_theta_max=5.0, omega=math.pi / 16)
    rclpy.spin(weird_turner)
    weird_turner.destroy_node()
    
    rclpy.shutdown()

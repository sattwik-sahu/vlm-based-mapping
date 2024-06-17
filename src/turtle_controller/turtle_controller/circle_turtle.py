from math import pi, cos
import rclpy
from rclpy.node import Node
from geometry_msgs.msg import Twist


class CircleTurtle(Node):
    def __init__(self, vel_theta: float = 1.0, omega: float = 1.57, timer_period: float = 0.02) -> None:
        Node.__init__(self, node_name="circle_turtle")
        self.vel_theta = vel_theta
        self.omega = omega
        self.timer_period = timer_period
        self._vel_pub = self.create_publisher(Twist, "/turtle1/cmd_vel", qos_profile=42)
        
        self.timer = self.create_timer(timer_period_sec=self.timer_period, callback=self._publish_velocity)
        
    def _publish_velocity(self) -> None:
        vel = Twist()
        vel.linear.x = self.vel_theta
        vel.angular.z = self.omega
        self._vel_pub.publish(msg=vel)
        
        self.get_logger().info(f"Published velocity {vel}")
        self.get_logger().info(f"Time = {self.get_clock().now()}")
        
        
def main():
    rclpy.init()
    
    circle_turtle = CircleTurtle(vel_theta=3.0)
    rclpy.spin(circle_turtle)
    circle_turtle.destroy_node()
    
    rclpy.shutdown()
